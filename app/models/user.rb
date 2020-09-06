class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    array = self.username.split(" ")
    slug = array.collect{|t| t.downcase}.join("-")
  end 

  def self.find_by_slug(slug)
    self.all.select{|user| slug == user.slug}.first
  end 

end
