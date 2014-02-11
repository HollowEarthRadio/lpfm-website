class ChangeProgramDescriptionToText < ActiveRecord::Migration
  def up
      change_column :programs, :description, :text
  end
  def down
      change_column :programs, :description, :string
  end
end
