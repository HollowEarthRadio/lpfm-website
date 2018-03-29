class AddAttachmentProgramImageToPrograms < ActiveRecord::Migration[4.2]
  def self.up
    change_table :programs do |t|
      t.attachment :program_image
    end
  end

  def self.down
    drop_attached_file :programs, :program_image
  end
end
