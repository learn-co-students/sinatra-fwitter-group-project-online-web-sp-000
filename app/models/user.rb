class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets
  has_secure_password
  validates :username, :email, :password, presence: true
  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods
end
