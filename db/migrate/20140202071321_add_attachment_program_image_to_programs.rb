class AddAttachmentProgramImageToPrograms < ActiveRecord::Migration
  def self.up
    change_table :programs do |t|
      t.attachment :program_image
    end
  end

  def self.down
    drop_attached_file :programs, :program_image
  end
end
