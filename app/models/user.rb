class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :programs
  has_and_belongs_to_many :roles

  validates :email, :password, presence: true
  validates :password, presence: true, :if => :password_required?
  validates :password_confirmation, presence: true, :if => :password_required?

  def role?(role)
    return !!self.roles.where(name: role.to_s).first
  end

  private

  def password_required?
     encrypted_password.blank? || !password.blank?
  end
end
