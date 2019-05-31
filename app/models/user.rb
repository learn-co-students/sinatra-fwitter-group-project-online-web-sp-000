class User < ActiveRecord::Base
  has_many :tweets
  validates :username, presence: true
  validates :email, presence: true
  validates :password, presence: true
  has_secure_password
end
