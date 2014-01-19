class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :body
      t.boolean :public

      t.timestamps
    end
  end
end
