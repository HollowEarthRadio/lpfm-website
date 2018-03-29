class AddTimestampsToPrograms < ActiveRecord::Migration[4.2]
  def change
    add_column :programs, :created_at, :datetime
    add_column :programs, :updated_at, :datetime
  end
end
