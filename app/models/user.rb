class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :programs
  has_and_belongs_to_many :roles

  validates :email, presence: true
  validates :password, presence: true, if: :password_required?
  validates :password_confirmation, presence: true, if: :password_required?

  def dj?
    roles.map(&:name).include?('dj')
  end

  def facebook?
    roles.map(&:name).include?('facebook')
  end
end
