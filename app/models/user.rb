require_relative './concerns/slugifable.rb'
class User < ActiveRecord::Base
  extend Slugifable::ClassMethods
  include Slugifable::InstanceMethods
  has_secure_password
  has_many :tweets
end
