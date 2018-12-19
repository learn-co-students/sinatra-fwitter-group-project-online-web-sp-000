class User < ActiveRecord::Base
  has_many :tweets
  validates_presence_of :username, :email
  has_secure_password
  
  def slug
    self.username.downcase.split(" ").join("-")
  end

  def self.find_by_slug(slug)
    User.all.find { |user| user.slug == slug }
  end
end