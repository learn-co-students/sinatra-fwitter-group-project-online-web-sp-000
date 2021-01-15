class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  validates :username, presence: true, uniqueness: true

  def slug
    username.downcase.strip.gsub(' ', '-')
  end

  def self.find_by_slug(slug)
    User.all.find do |user|
      user.slug == slug
    end
  end
end
