module ApplicationHelper

  def listen_link(title)
    link_to title, "http://www.streamlicensing.com/stations/hollowearth/listen.html"
  end

  def info_mailto
   standard_mailto("info", "email us")
  end

  def dj_mailto
   standard_mailto("dj", "EMAIL DJ")
  end

  def music_mailto
   standard_mailto("music", "Music Department")
  end

  def volunteer_mailto
    standard_mailto("volunteer", "Volunteer Coordinator")
  end

  def email_list
    standard_mailto("publicity", "Mailing List")
  end

  private

  def standard_mailto(email_prefix, title)
    mail_to "#{email_prefix}@hollowearthradio.org?subject=I want to be on the hollow earth mailing list!", title
  end
end
