require_relative '../models/slugifiable.rb'

class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods
end
