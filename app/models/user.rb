class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    self.username.downcase.split(" ").join("-")
  end

  def self.find_by_slug(search_slug)
    self.all.find { |user| user.slug == search_slug }
  end

end
