class User < ActiveRecord::Base
  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods
  has_secure_password
  has_many :tweets
  validates_presence_of :email, :username, :password
end
