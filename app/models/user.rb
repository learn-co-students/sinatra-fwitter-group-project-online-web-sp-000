class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def self.find_by_slug(slug)
    all.detect { |s| s.slug == slug }
  end

  def slug
    username.downcase.gsub(" ", "-")
  end

end
