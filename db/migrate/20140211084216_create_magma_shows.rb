class CreateMagmaShows < ActiveRecord::Migration[4.2]
  def change
    create_table :magma_shows do |t|
      t.string :name
      t.datetime :date
      t.string :link
      t.text :body
      t.string :venue
      t.attachment :poster_image
      t.timestamps
    end
  end
end
