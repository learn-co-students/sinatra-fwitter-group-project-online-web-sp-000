class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  def slug
    self.username.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    User.all.detect {|user| user.username.downcase.gsub(" ", "-") == slug}
  end
end
