class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  validates :email, :username, :password, presence: true

  def slug
  	self.username.gsub(' ', '-')
  end

  def self.find_by_slug(slug)
  	slug = slug.gsub('-', ' ')
  	self.find_by(username: slug)
  end
end
