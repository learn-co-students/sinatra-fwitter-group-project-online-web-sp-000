require_relative './concerns/slugifable.rb'
class User < ActiveRecord::Base
  extend Slugifable::ClassMethods
  include Slugifable::InstanceMethods
  has_secure_password

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  has_many :tweets
end
