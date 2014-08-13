class AddFacebookToEvents < ActiveRecord::Migration
  def change
    add_column :events, :featured, :boolean
    add_column :events, :start_time, :datetime
    add_column :events, :location, :string
    add_column :events, :fb_id, :string
    add_column :events, :fb_image, :string
  end
end
