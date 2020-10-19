class User < ActiveRecord::Base
  
  #Added for module slugify
  require_relative './slugify.rb'
  require_relative './helpers.rb'
  include Slugify::InstanceMethod
  include Helpers::InstanceMethod
  extend Slugify::ClassMethod
  extend Helpers::ClassMethod
  #----

  #Added dependencies
  has_secure_password
  has_many :tweets
  #----
  
end
  