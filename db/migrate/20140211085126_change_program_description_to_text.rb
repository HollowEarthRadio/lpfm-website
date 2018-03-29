class ChangeProgramDescriptionToText < ActiveRecord::Migration[4.2]
  def up
      change_column :programs, :description, :text
  end
  def down
      change_column :programs, :description, :string
  end
end
