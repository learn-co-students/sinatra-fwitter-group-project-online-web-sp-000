class User < ActiveRecord::Base
  # validates :email, uniqueness: true
  # validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  # validates :username, uniqueness: true
  # Validates :password, presence: true


  has_secure_password
  has_many :tweets
end
