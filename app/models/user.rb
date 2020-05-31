class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  validates :email, :username, :password, presence: true

  def slug
  	self.username
  end

  def find_by_slug(slug)
  	User.find_by(name: slug)
  end
end
