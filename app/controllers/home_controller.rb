class HomeController < ApplicationController
  layout "index"

  def index
    @program = Program.first
    @events = Event.public
  end
end
