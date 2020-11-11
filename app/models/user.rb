class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    self.username.downcase.split(" ").join("-")
  end

  def self.find_by_slug(slug)
    User.all.find do |user|
      user.slug == slug
    end
  end
end
