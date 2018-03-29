class AddMixcloudToProgram < ActiveRecord::Migration[4.2]
  def change
    add_column :programs, :mixcloud, :string
  end
end

