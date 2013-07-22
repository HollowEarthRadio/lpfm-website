class Program < ActiveRecord::Base
  has_and_belongs_to_many :users, :uniq => true

  scope :random,  -> { where(archived: false).sample }
end
