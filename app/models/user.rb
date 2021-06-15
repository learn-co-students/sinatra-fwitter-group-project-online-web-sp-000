class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    self.username.parameterize
  end

  def self.find_by_slug(slug)
    self.all.find {|s| s.slug == slug}
  end
end
