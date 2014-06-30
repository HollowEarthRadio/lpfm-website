class ProgramsController < ApplicationController
  layout "default"

  before_action :set_twitter_id

  def index
    @programs = Program.scheduled.order("updated_at DESC")
  end

  def show
    @program = Program.find(params[:id])
    if @program && @program.twitter_id.present?
      @twitter_id = @program.twitter_id
    end
  end

  private

  def set_twitter_id
    @twitter_id = "hollowearth"
  end
end
