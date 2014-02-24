class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name, :last_name, :bio, :avatar, :email, :role, :password, :password_confirmation, :remember_me

  has_many :subscriptions, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

end