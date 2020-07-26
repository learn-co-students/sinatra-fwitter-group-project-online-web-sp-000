class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password
  

  def slug
    @slug = self.username.split().join("-")
  end

  def self.find_by_slug(slug)
   self.all.detect {|user| user.slug == slug}
  end
end
