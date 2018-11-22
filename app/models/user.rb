class User < ActiveRecord::Base
  has_secure_password
  validates_presence_of :username, :password
  has_many :tweets

  def slug
    username.downcase.strip.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    self.all.find{ |user| user.slug == slug }
  end

end
