class AddTwitterNameToPrograms < ActiveRecord::Migration
  def change
    add_column :programs, :twitter_id, :string, limit: 15, null: true
  end
end
