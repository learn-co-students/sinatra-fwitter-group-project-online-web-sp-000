class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets
  extend Slugify::ClassMethods
  include Slugify::InstanceMethods
end
