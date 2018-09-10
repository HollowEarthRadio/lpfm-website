class Role < ActiveRecord::Base
  has_and_belongs_to_many :users

  validates :name, uniqueness: true

  def self.users(type)
    role = Role.find_by_name(type)
    role.nil? ? [] : role.users
  end

  def self.djs
    users("dj")
  end

  def self.facebook_admins
    users("facebook")
  end
end
