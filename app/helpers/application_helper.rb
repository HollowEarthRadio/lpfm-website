module ApplicationHelper

  def listen_link(title)
    link_to title, "listen"
  end

  def map_link
    link_to "2018a E. Union St, Seattle, WA 98122", "https://maps.google.com/maps?q=2018a+E+Union+St,+Seattle,+WA&hl=en&sll=47.613028,-122.342064&sspn=0.268013,0.396881&hnear=2018+E+Union+St,+Seattle,+Washington+98122&t=m&z=16"
  end

  def info_mailto(msg = "email us")
   standard_mailto("info", msg)
  end

  def booking_mailto(msg = "book a show")
   standard_mailto("booking", msg)
  end

  def dj_mailto(msg = "EMAIL DJ")
   standard_mailto("dj", msg)
  end

  def music_mailto(msg = "Music Department")
   standard_mailto("music", msg)
  end

  def volunteer_mailto(msg = "Volunteer Coordinator")
    standard_mailto("volunteer", msg)
  end

  def dj_application(msg = "Want a show? Fill out our ONLINE APPLICATION")
    link_to(msg, "https://to.khuh.club/wannadj", target: '_blank')
  end

  private

  def standard_mailto(email_prefix, title)
    mail_to "#{email_prefix}@hollowearthradio.org", title
  end
end
