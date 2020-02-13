class User < ActiveRecord::Base
  include Slugafiable::InstanceMethods
  extend Slugafiable::ClassMethods
  has_many :tweets
  has_secure_password
  validates :username, :email, :password, presence: true
end