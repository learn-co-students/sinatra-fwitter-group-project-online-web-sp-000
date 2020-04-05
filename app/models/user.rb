class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    self.username.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    self.all.find {|x| x.slug == slug}
  end
end
