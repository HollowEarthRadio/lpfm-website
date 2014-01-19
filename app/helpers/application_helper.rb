module ApplicationHelper

  def dj_mailto
    mail_to "dj@hollowearthradio.org?subject=I want to give you my first born child", "EMAIL DJ"
  end

  def listen_link(title)
    link_to title, "http://www.loudcity.com/stations/hollow-earth-radio/files/show/listen.html"
  end
end
