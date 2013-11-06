class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :programs
  has_and_belongs_to_many :roles

  validates :email, :login, :password, presence: true
  validates :password, presence: true, :if => :password_required?
  validates :password_confirmation, presence: true, :if => :password_required?

end
