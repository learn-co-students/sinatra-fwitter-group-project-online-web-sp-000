require_relative './concerns/slugify.rb'

class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets
  
  
  include Slugifiable::InstanceMethod
  extend Slugifiable::ClassMethod
end
