class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets
  validates_presence_of :username, :email, :password

  def slug
    self.username.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(myslug)
    all.find do |myuser|
      myuser.slug == myslug
    end
  end
end
