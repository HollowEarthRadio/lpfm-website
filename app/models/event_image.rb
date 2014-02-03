class EventImage < ActiveRecord::Base
  belongs_to :event
  validates :attachment, attachment_presence: true
end
