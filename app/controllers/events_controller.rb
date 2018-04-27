class EventsController < ApplicationController
  layout "default"

  def index
    @events = Event.future.visible.order(start_time: :asc)
  end
end
