class User < ActiveRecord::Base
  validates_presence_of :username, :email, :password
  has_secure_password
  has_many :tweets

  def self.find_by_slug(slug)
    result = self.all.select {|elem| elem.slug == slug }.first      
  end

  def slug
    self.username.downcase.gsub(" ", "-")
  end
end
