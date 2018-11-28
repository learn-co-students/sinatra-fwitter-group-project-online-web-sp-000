class User < ActiveRecord::Base
  validates :username, :email, presence: true
  has_secure_password
  has_many :tweets

  def slug
    self.username.gsub(" ", "-").downcase
  end

  def self.find_by_slug(slug)
    self.all.detect { |user| user.slug == slug }
  end
end
