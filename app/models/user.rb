class User < ActiveRecord::Base
  has_many :tweets
  validates_presence_of :username, :email, :password_digest
  has_secure_password
end