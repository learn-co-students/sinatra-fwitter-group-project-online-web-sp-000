class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  validates :username, :email, presence: true
  validates :email, uniqueness: true

  def slug
    self.username.parameterize
  end

  def self.find_by_slug(slug)
    self.find_by(username: slug.titleize.downcase)
  end
end
