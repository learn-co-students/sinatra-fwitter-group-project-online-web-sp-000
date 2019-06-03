class User < ActiveRecord::Base
  has_many :tweets
  validates :username, presence: true
  validates :email, presence: true
  validates :password, presence: true
  has_secure_password

  def slug
    self.username.gsub(" ", "-").downcase
  end

  def self.find_by_slug(slug)
    self.all.find do |user|
      user.slug == slug
    end
  end
end
