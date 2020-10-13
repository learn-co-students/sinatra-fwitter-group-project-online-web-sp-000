class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets


  def slug
    namesplittoarray  = self.username.downcase.split(" ")
    slug = namesplittoarray.join("-")

  end

  def self.find_by_slug(theslug)
    user = User.all.find do | user |
      user.slug == theslug
    end
    #we have to use find method, not find_by, becaue .slug is not an attribute, but a method
  end

end
