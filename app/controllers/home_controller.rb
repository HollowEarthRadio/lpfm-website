class HomeController < ApplicationController
  layout "default"

  def index
    @program = Program.first
    @events = Event.public
  end

  def splash
    render layout: false
  end
end
