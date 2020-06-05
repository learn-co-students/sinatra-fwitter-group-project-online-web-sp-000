class User < ActiveRecord::Base
  extend Helpers::ClassMethods
  include Helpers::InstanceMethods
  has_secure_password
  has_many :tweets
   
end

