class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets
  validates :username, presence: true
  validates :email, presence: true
  validates :password_digest, presence: true

  def slug
    self.username.gsub(" ", "-")
  end

  def self.find_by_slug(name)
    self.find_by(username: name.gsub("-", " "))
  end

end
