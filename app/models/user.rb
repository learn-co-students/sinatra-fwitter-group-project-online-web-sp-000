require_relative './concerns/slugfiable.rb'

class User < ActiveRecord::Base
  include Slugfiable::InstanceMethods
  extend Slugfiable::ClassMethods

  has_secure_password
  has_many :tweets

  validates_presence_of :username, :email, :password


end
