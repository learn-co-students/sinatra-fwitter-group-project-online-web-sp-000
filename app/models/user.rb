class User < ActiveRecord::Base
  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods
  has_secure_password
  has_many :tweets
  validates_presence_of :username, :email, :password
end
