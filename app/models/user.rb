class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    slugify = self.username.downcase 
    slugify.gsub(" ", "-")
  end   

  def self.find_by_slug(slug)
    unslug = slug.gsub("-", " ")
    self.all.find { |user| user.username.downcase == unslug }
  end  
end
