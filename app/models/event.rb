class Event < ActiveRecord::Base
  scope :public, -> { where(public: true) }

  has_attached_file :event_image, styles: { cropped: '200x200!' }
end
