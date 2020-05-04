class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  validates :username, presence: true
  validates :email, presence: true
  validates :password, presence: true

  def slug
    self.username.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    self.find {|user| user.slug == slug}
  end
end
