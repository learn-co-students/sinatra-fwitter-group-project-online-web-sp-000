class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  validates_presence_of :username
  validates_presence_of :email
  validates_presence_of :password
  
end
