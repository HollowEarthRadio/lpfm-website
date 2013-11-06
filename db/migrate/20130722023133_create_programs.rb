class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.string :name
      t.string :description
      t.string :air_times
      t.string :rebroadcast_times
      t.string :external_link_name
      t.string :external_link
      t.boolean :archived, default: false, null: false
    end

    create_table :programs_users, id: false, force: true do |t|
      t.integer :user_id
      t.integer :program_id
    end
  end
end
