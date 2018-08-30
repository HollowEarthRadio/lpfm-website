class FacebookToken < ApplicationRecord
  def self.latest
    FacebookToken.order("created_at").last
  end
end
