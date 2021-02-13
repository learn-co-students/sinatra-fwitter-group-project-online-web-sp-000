class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug 
    self.username.gsub(" ", "-")
  end 

  def self.find_by_slug(slug)
    #binding.pry
    un = slug.split("-").join(" ") 
    User.find_by(username: un)
  end 
end
