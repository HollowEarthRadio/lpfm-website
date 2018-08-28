class FacebookToken < ApplicationRecord
  def latest
    FacebookToken.order_by("created_at").last
  end
end
