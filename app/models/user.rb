class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    stripped_name = self.username.downcase.split(/[.+ ]/)
    
    slug_name = stripped_name.join("-")

    slug_name
  end

  def self.find_by_slug(slug)
    self.all.find{|user| user.slug == slug}
  end

end
