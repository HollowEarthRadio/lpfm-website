class ProgramsController < ApplicationController
    def index
        @programs = Program.find(:all, :order => "updated_at DESC", :conditions => {:parent_id => nil })

        respond_to do |format|
            format.html # index.html.erb
            format.json {render :text => {:status => "ok", :operation => "index", :data => @programs}.to_json}
        end
    end

    def new
        @program = Program.new
    end

    def create

        if params[:programs_users_ids].nil?
            flash[:notice] = "Please select 1 or more dj's for this program!"
            redirect_to :controller => 'programs', :action => 'new'
        else
            @program = Program.create(params[:program])
            params[:programs_users_ids].each do |userid|
                u = User.find(userid.to_i)
                @program.users << u
            end
            if @program.save
                update_is_broadcasting(@program)
                flash[:notice] = "Program saved!"
                redirect_to :action => "index"
            else
                flash[:notice] = "Program not saved!"
                redirect_to :action => "new"
            end
        end

    end

    def show
        @program = Program.find(params[:id])
        @playlist_days = IcyPlaylist.days_with_playlist_for_program(@program)
    end

    # REQUIRED
    # PROGRAM ID
    # PLAYLIST DAY
    def playlists
        @playlist = IcyPlaylist.playlists_for_program_on_day(params[:id], params[:day])
        logger.error @playlist.count
        @playlist.each do |t|
            if t.icy_track.nil?
               logger.error "NILL #{t.icy_track}"
               IcyPlaylist.delete(t)
            else
                logger.error t.icy_track.title
            end
        end
        @playlist = IcyPlaylist.playlists_for_program_on_day(params[:id], params[:day])
        @day = params[:day]
        @program = Program.find(params[:id])
    end

    def edit
        @program = Program.find(params[:id])
    end

    def update
        @program = Program.find(params[:id])

        # If the user has supplied some dj ids ....
        if !params[:programs_users_ids].nil?
            # Delete all the old djs
            @program.users.delete_all

            #Add each dj that was chosen to this programs associated djs
            params[:programs_users_ids].each do |userid|
                @program.users << User.find(userid)
            end
        end

        if @program.update_attributes(params[:program])
            update_is_broadcasting(@program)
            flash[:notice] = 'Program was successfully updated.'
        else
            flash[:error] = 'Program was not successfully updated.'
        end
        redirect_to :action => "index"
    end

    def delete
        @program = Program.find(params[:id])
        @program.destroy

        respond_to do |format|
            format.html { redirect_to(programs_url) }
            format.xml  { head :ok }
        end

    end

    private

    def update_is_broadcasting(program)
        if params[:program][:is_broadcasting] == "1"
            Program.logout_other_djs
            p = Program.find(@program.id)
            p.is_broadcasting = true
            p.save!
            logger.error "@program.is_broadcasting = #{p.is_broadcasting}"
            @program = p.update_attributes(:is_broadcasting => "1", :broadcast_startime => (p.broadcast_startime.nil? ? Time.now : p.broadcast_startime) )
        else
            p = Program.find(@program.id)
            p.is_broadcasting = false
            p.broadcasting_hours = 0
            p.broadcast_startime = nil
            p.save!
            logger.error "params broadcasting does not equal 1"
        end
    end

    def belongs_to_program
        @program = Program.find(params[:id])
        puts @program.users.include?(current_user)
        if !logged_in? || !@program.users.include?(current_user)
            access_denied
        end
    end

end
