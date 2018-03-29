class AddTwitterNameToPrograms < ActiveRecord::Migration[4.2]
  def change
    add_column :programs, :twitter_id, :string, limit: 15, null: true, default: nil
  end
end
