require_relative "./concerns/slugable.rb"
class User < ActiveRecord::Base
  extend Slugable::ClassMethods
  include Slugable::InstanceMethods
  has_secure_password
  has_many :tweets
end
