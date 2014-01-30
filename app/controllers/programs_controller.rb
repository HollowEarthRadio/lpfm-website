class ProgramsController < ApplicationController
  layout "default"

  def index
    @programs = Program.scheduled.order("updated_at DESC")
  end

  def show
    @program = Program.find(params[:id])
  end
end
