require_relative './concerns/slugify.rb'

class User < ActiveRecord::Base
      
    #all instances of User have access to Slugifiable's methods (as instance methods)
    include Slugifiable 

    #User has Slugifiable's methods (as class methods)
    extend Slugifiable
  has_secure_password
  has_many :tweets
end
