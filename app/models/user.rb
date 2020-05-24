class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  validates :username, presence: true
  validates :email, presence: true
  validates :password, presence: true

  def slug
    username.gsub(" ",'-').downcase
  end

  def self.find_by_slug(slug)
    # binding.pry
    User.find_by_username(slug.gsub('-',' '))
  end
end
