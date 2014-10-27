class AddFacebookToEvents < ActiveRecord::Migration
  def change
    add_column :events, :featured, :boolean, default: false
    add_column :events, :start_time, :datetime
    add_column :events, :no_start_time, :boolean, default: true
    add_column :events, :location, :string
    add_column :events, :fb_id, :string
  end
end
