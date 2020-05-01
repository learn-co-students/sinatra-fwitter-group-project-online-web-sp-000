class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets
  validates_uniqueness_of :username
  validates_uniqueness_of :email
  validates :username, presence: true
  validates :email, presence: true
  validates :password, presence: true
  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods
end
