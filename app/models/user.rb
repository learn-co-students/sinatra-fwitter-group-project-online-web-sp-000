class User < ActiveRecord::Base
  include Slugifiable::InstanceMethod
  extend Slugifiable::ClassMethod
  has_secure_password
  has_many :tweets

  validates_presence_of  :username, :email, :password
end
