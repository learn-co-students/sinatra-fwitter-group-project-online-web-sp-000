class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets
  validates_presence_of :email, :username, :password

  def slug
    self.username.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    User.all.find do |user|
      if user.slug == slug
        user
      end
    end
  end
end
