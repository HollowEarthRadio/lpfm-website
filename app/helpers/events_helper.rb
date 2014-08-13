module EventsHelper
 
  def facebook_event_link(text, id)
    link_to text, "https://www.facebook.com/events/" + id
  end

end
