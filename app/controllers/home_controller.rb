class HomeController < ApplicationController

  def index
    @program = Program.first
    @events = Array.new
    # @events = Event.find(:all, :conditions => {:is_public => true}, :order => 'updated_at DESC')
    # @now = IcyPlaylist.find(:first, :order => "played_at DESC")
    # @playlist = IcyPlaylist.find(:all, :limit => 5, :order => "played_at DESC")
  end
end
