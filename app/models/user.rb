class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug 
    self.username.parameterize unless self.username == nil
  end 

  def self.find_by_slug(slug)
    self.all.find {|name| name.slug == slug}
  end 
  
end
