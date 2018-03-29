class AddAttachmentEventImageToEvents < ActiveRecord::Migration[4.2]
  def self.up
    change_table :events do |t|
      t.attachment :event_image
    end
  end

  def self.down
    drop_attached_file :events, :event_image
  end
end
