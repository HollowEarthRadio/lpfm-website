class EventsController < ApplicationController
  layout "default"

  def index
    @events = Event.future.visible
  end
end
