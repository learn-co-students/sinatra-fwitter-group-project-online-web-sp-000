class User < ActiveRecord::Base
  has_many :tweets

  has_secure_password

  validates_presence_of :username
  validates_presence_of :email
  validates_presence_of :password

  def slug
    username.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    User.all.find { |user| user.slug == slug}
  end

end
