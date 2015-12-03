class AddMixcloudToProgram < ActiveRecord::Migration
  def change
    add_column :programs, :mixcloud, :string
  end
end

