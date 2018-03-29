class AddDjNameToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :dj_name, :string
  end
end
