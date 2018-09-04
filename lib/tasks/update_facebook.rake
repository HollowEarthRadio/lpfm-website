# This script is based on a script written by Isaac Liu for pulling event
# data from Facebook using the FBGraph rails gem.
#
# See https://github.com/iliu/mysite-examples/tree/fb_graph_cache for the
# original code.

desc "This task is called by the Heroku scheduler add-on"
task :update_facebook => :environment do
  begin
    update_facebook_events
  rescue => e
    puts e.message
    puts e.backtrace
    FacebookMailer.failure_email(e)
  end
end

def update_facebook_events
  puts "Updating facebook..."
  puts "***Updating facebook events***"

  t1 = Time.now
  puts "================"
  puts Time.now.strftime("%Y%m%d-%H%M%S") + " : " + __FILE__ + " starting..."

  puts "\ngrabbing file lock....."
  if File.new(__FILE__).flock(File::LOCK_EX | File::LOCK_NB) == false
    puts "*** can't lock file, another instance of script running?  exiting"
    exit 1
  end

  puts "obtained file lock... starting facebook api calls...\n"
  # do the processing...
  # ...

  ##################
  # FACEBOOK ACCESS
  ##################
  page_token = get_facebook_page_token

  puts "\nGetting page API"
  koala_api = Koala::Facebook::API.new(page_token)

  fb_events = get_facebook_events(koala_api)

  #need to fetch event by identifier so you get all the information
  puts "\nSearching for dirty events..."

  fb_events.each do |e|
    event_details = get_facebook_event_details(koala_api, e["id"])

    edatabase = Event.where(:fb_id => event_details["id"]).first;
    if edatabase
      update_facebook_event(event_details, edatabase)
    else
      create_new_facebook_event(event_details)
    end
  end

  puts "\nUpdate complete."

  t2 = Time.now
  puts Time.now.strftime("%Y%m%d-%H%M%S") + " : " + __FILE__ + " finished  #{t2 - t1} secs"
  puts "================"
end

def get_facebook_page_token
  puts "\nGetting user access token"
  user_access_token = FacebookToken.latest.access_token

  puts "\nFinding page access token"
  koala_user_api = Koala::Facebook::API.new(user_access_token);
  accounts = koala_user_api.get_object("me/accounts", { fields: "name,id,access_token" })

  hollow_earth_account = accounts.find{ |account| account["name"]=="Hollow Earth Radio" }
  hollow_earth_account["access_token"]
  'foobar'
end

def get_facebook_events(koala_api)
  puts "\nAccessing facebook events "
  koala_api.get_connection("me", "events").sort_by {|i| i["start_time"]}
end

def get_facebook_event_details(koala_api, event_id)
  koala_api.get_object(event_id, { fields: "cover,description,updated_time,name,start_time,id,interested_count,place" });
end

def update_facebook_event(event_details, edatabase)
  if has_event_been_updated(event_details, edatabase.updated_at)
    puts "\n**found dirty facebook event - "+ event_details["name"]

    edatabase.name = event_details["name"]
    edatabase.start_time = event_details["start_time"].to_datetime
    edatabase.location = event_details["place"]["name"]
    edatabase.body = get_facebook_event_description(event_details)
    edatabase.fb_id = event_details["id"]
    edatabase.event_image = get_facebook_event_picture(event_details)
    edatabase.save
    puts "***updated "+edatabase.name
  else
    puts "\n**facebook event is not dirty, skipping - " + event_details["name"]
  end
end

def has_event_been_updated(event_details, last_updated_at)
  !event_details["updated_time"].nil? && (event_details["updated_time"] > last_updated_at)
end

def create_new_facebook_event(event_details)
  puts "***database entry not found, adding to database "+ event_details["name"]
      
  edatabase = Event.new( :name => event_details["name"],
                         :start_time => event_details["start_time"].to_datetime,
                         :no_start_time => false,
                         :location => event_details["place"]["name"],
                         :body => get_facebook_event_description(event_details),
                         :public => true,
                         :featured => false,
                         :fb_id => event_details["id"],
                         :event_image => get_facebook_event_picture(event_details) )
  edatabase.save
  puts "***saved "+edatabase.name
end

def get_facebook_event_description(event_details)
  fb_event_description = ""
  unless event_details["description"].nil? || event_details["description"].blank?
    fb_event_description = event_details["description"];
  end

  fb_event_description
end

def get_facebook_event_picture(event_details)
  fb_picture = nil

  unless event_details["cover"].nil? || event_details["cover"].blank? || event_details["cover"]["source"].nil? || event_details["cover"]["source"].blank?
    fb_picture_url = event_details["cover"]["source"]
    fb_picture = open(fb_picture_url)
  end

  fb_picture
end

