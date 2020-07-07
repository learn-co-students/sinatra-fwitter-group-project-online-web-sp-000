class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets
  validates :username, :email, :password, presence: true

  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods
end
