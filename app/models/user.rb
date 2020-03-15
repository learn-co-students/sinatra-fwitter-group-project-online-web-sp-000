class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    username.downcase.split(" ").join("-")
  end

  def self.find_by_slug(slug)
    all.each do |o|
      return o if o.slug == slug
    end
  end
end
