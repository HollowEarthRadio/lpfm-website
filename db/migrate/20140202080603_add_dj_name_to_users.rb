class AddDjNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :dj_name, :string
  end
end
