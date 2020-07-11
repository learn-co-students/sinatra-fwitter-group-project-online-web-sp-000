class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    self.username.split.join("-").downcase
  end

  def self.find_by_slug(slug)
    username = slug.split("-").join(" ")
    self.find_by(username: username)
  end
end
