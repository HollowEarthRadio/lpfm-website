class AddLiveSettingsToProgram < ActiveRecord::Migration[4.2]
  def change
    add_column :programs, :is_broadcasting, :boolean, default: false, null: false
    add_column :programs, :broadcast_starttime, :datetime
    add_column :programs, :message, :text
  end
end
