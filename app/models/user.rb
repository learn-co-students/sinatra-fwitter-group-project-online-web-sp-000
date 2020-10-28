class User < ActiveRecord::Base

  extend Slugify::ClassMethods
  include Slugify::InstanceMethods
  extend Helpers::ClassMethods
  include Helpers::InstanceMethods

    has_secure_password
    has_many :tweets

    validates :username, presence: true  
    validates :email, presence: true, uniqueness: true
    validates :password_digest, presence: true
  
  
end
