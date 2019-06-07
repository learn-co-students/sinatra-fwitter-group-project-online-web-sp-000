class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  def slug
    self.username.split.join("-")

  end

  def self.find_by_slug(slug)
    self.all.find do |u|
      if u.slug == slug
        u
      end
    end
  end
end
