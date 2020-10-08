class User < ActiveRecord::Base
  include Slugify::InstanceMethods
  extend Slugify::ClassMethods  
  
  validates_presence_of :username, :email, :password
  has_secure_password
  has_many :tweets
end