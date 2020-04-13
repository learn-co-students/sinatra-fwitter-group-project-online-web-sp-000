class User < ActiveRecord::Base

  attr_accessor :password_digest

  has_secure_password
  has_many :tweets

  def slug
    self.username.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    name = slug.gsub("-"," ")
    User.find_by(username: name)
  end

end
