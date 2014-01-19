class Event < ActiveRecord::Base
  scope :public, -> { where(public: true) }
end
