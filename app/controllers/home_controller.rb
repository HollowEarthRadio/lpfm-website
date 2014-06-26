class HomeController < ApplicationController
  layout "default"

  before_action :set_twitter_id

  def index
    @program = Program.random
    @events = Event.public.order('updated_at DESC')
  end

  def splash
    render layout: false
  end

  def magma
    @magma_shows = MagmaShow.all.order("date ASC")
    @sponsors = Sponsor.all.where(year: Time.zone.now.year.to_s)
  end

  private

  def set_twitter_id
    @twitter_id = "hollowearth"
  end
end
