# This script is based on a script written by Isaac Liu for pulling event
# data from Facebook using the FBGraph rails gem.
#
# See https://github.com/iliu/mysite-examples/tree/fb_graph_cache for the
# original code.

desc "This task is called by the Heroku scheduler add-on"
task :update_facebook => :environment do
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
  oauth_app = Koala::Facebook::OAuth.new(ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET']);
  user_access_token = FacebookToken.latest.access_token

  koala_user_api = Koala::Facebook::API.new(user_access_token);

  accounts = koala_user_api.get_object("me/accounts", { fields: "name,id,access_token" })

  hollow_earth_account = accounts.find{ |account| account["name"]=="Hollow Earth Radio" }

  koala_api = Koala::Facebook::API.new(hollow_earth_account["access_token"])

  fb_events = koala_api.get_connection("me", "events").sort_by {|i| i["start_time"]}
  puts "\nAccessing facebook events "
  #need to fetch event by identifier so you get all the information
  puts "\nSearching for dirty events..."

  fb_events.each do |e|
    ie = koala_api.get_object(e["id"], { fields: "cover,description,updated_time,name,start_time,id,interested_count,place" });

    unless e["id"].nil? || e["id"].blank? || ie["cover"].nil? || ie["cover"].blank? || ie["cover"]["source"].nil? || ie["cover"]["source"].blank?
      fb_picture_url = ie["cover"]["source"]
      fb_picture = open(fb_picture_url)
    else
      fb_picture_url = ""
      fb_picture = nil
    end

    unless ie["description"].nil? || ie["description"].blank?
      fb_event_description = ie["description"];
    else
      fb_event_description = "";
    end

    edatabase = Event.where(:fb_id => ie["id"]).first;
    if edatabase
      if !ie["updated_time"].nil? && ie["updated_time"] > edatabase.updated_at
  
        puts "\n**found dirty facebook event - "+ie["name"]

        edatabase.name = ie["name"]
        edatabase.start_time = ie["start_time"].to_datetime
        edatabase.location = ie["place"]["name"]
        edatabase.body = fb_event_description
        edatabase.fb_id = ie["id"]
        edatabase.event_image = fb_picture
        edatabase.save
        puts "***updated "+edatabase.name
      else
        puts "\n**facebook event is not dirty, skipping - " + ie["name"]
      end
    else
      puts "***database entry not found, adding to database "+ie["name"]
      
      edatabase = Event.new( :name => ie["name"],
                             :start_time => ie["start_time"].to_datetime,
                             :no_start_time => false,
                             :location => ie["place"]["name"],
                             :body => fb_event_description,
                             :public => true,
                             :featured => false,
                             :fb_id => ie["id"],
                             :event_image => fb_picture )
      edatabase.save
      puts "***saved "+edatabase.name
    end
  end

  puts "\nUpdate complete."

  t2 = Time.now
  puts Time.now.strftime("%Y%m%d-%H%M%S") + " : " + __FILE__ + " finished  #{t2 - t1} secs"
  puts "================"
end
