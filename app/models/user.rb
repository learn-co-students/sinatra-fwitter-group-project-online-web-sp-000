class User < ActiveRecord::Base
  has_secure_password
  validates :username, :email, presence: true
  has_many :tweets

  def slug
    self.username.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    find_by(username: slug.gsub("-"," "))
  end
end
