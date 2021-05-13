class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets
  extend Slugfiable::ClassMethods
  include Slugfiable::InstanceMethods
end
