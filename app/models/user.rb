class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  require_relative './concerns/slugifiable'
  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods

end