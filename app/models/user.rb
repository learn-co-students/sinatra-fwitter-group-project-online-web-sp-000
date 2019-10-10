class User < ActiveRecord::Base
  has_secure_password 
  has_many :tweets 


  def slug
    # word.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
    self.username.downcase.split(" ").join("-")
  end 

  def self.find_by_slug(slug)
    # binding.pry
    User.find_by(username: slug.split("-").join(" "))
  end 
end 