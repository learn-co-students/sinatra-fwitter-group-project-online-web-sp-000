
class User < ActiveRecord::Base
  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods
  has_secure_password
  has_many :tweets
  validates_presence_of :username, :email, :password
  scope :ci_find, lambda { |attribute, value| where("lower(#{attribute}) = ?", value.downcase).first }
end
