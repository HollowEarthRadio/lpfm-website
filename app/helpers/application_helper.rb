module ApplicationHelper

  def listen_link(title)
    link_to title, "listen"
  end

  def map_link
    link_to "... WE ARE MOVING BUT DONT HAVE A NEW SPACE YET PLEASE SEND ANY MAIL TO: P.O. Box 21066, Seattle, WA 98111", "https://www.hollowearthradio.org/contact"
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
    link_to(msg, "https://airtable.com/shrngmv1iKvwHZNNf", target: '_blank')
  end

  private

  def standard_mailto(email_prefix, title)
    mail_to "#{email_prefix}@hollowearthradio.org", title
  end
end
