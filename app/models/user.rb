class User < ActiveRecord::Base
  include Slugifiable

  has_secure_password
  has_many :tweets

end
