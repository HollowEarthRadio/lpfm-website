class CreateSponsors < ActiveRecord::Migration[4.2]
  def change
    create_table :sponsors do |t|
      t.string :name
      t.string :link
      t.string :year

      t.timestamps
    end
  end
end
