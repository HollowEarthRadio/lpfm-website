class HomeController < ApplicationController
  layout "default"

  def index
    @program = Program.first
    @events = Event.public
  end

  def splash
    render layout: false
  end

  def magma
    @magma_shows = MagmaShow.all.order("date ASC")
  end
end
