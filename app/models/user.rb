class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets
  
  def slug
    self.username.strip.split.join("-")
  end
  
  def self.find_by_slug(slug)
    to_find = slug.split("-").collect do |name|
      name
    end.join(" ")
    self.find_by(username: to_find)
    end
end
