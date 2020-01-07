class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    username.parameterize
 end

 def self.find_by_slug(slug)
     self.all.find{|name| name.slug == slug}
 end
end
