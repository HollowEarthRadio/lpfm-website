# This script is based on a script written by Isaac Liu for pulling event
# data from Facebook using the FBGraph rails gem. 
#
# See https://github.com/iliu/mysite-examples/tree/fb_graph_cache for the
# original code.

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
config = YAML::load(File.open(Rails.root.join('config','facebook.yml')));
oauth_app = Koala::Facebook::OAuth.new(config['production']['app_id'], config['production']['app_secret']);
access_token = oauth_app.get_app_access_token;
koala_api = Koala::Facebook::API.new(access_token);

fb_events = koala_api.get_connections("hollowearthradio", "events").sort_by {|i| i["start_time"]}
puts "\nAccessing facebook events "
#need to fetch event by identifier so you get all the information
puts "\nSearching for dirty events..."

fb_events.each do |e|
  ie = koala_api.get_object(e["id"]);
  picture = koala_api.get_picture(e["id"], { type: "large" });

  edatabase = Event.where(:fb_id => ie["id"]).first;
  if edatabase
    if ie["updated_time"] > edatabase.updated_at
      puts "\n**found dirty facebook event - "+ie["name"]

      edatabase.name = ie["name"]
      edatabase.start_time = ie["start_time"].to_datetime
      edatabase.location = ie["location"]
      edatabase.body = ie["description"].gsub!('\n', '<br>')
      edatabase.fb_id = ie["id"]
      edatabase.fb_image = picture
      edatabase.save
      puts "***updated "+edatabase.name
    else 
      puts "\n**facebook event is not dirty, skipping - " + ie["name"]
    end
  else
    puts "***database entry not found, adding to database "+ie["name"]
    edatabase = Event.new( :name => ie["name"], 
                           :start_time => ie["start_time"].to_datetime,
                           :location => ie["location"],
                           :body => ie["description"].gsub("\n", "<br>"),
                           :public => true,
                           :fb_id => ie["id"],
                           :fb_image => picture )
    edatabase.save
    puts "***saved "+edatabase.name
  end
end

puts "\nUpdate complete."

t2 = Time.now
puts Time.now.strftime("%Y%m%d-%H%M%S") + " : " + __FILE__ + " finished  #{t2 - t1} secs"
puts "================"
