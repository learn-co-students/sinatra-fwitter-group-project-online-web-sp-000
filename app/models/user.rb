class User < ActiveRecord::Base
  has_many :tweets

  validates_presence_of :username, :email

  has_secure_password
  validates_presence_of :password
end
