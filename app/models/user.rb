require_relative 'concerns/slugifiable'

class User < ActiveRecord::Base
  include Slugifiable
  extend Slugifiable
  has_secure_password
  has_many :tweets
end
