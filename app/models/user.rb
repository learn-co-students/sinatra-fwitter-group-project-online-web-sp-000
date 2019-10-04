class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    slug_name = self.username.downcase.split(" ")
    slug_name.join("-")
  end

  def self.find_by_slug(slug_name)
    User.all.find{|user| user.slug == slug_name}
  end

end
