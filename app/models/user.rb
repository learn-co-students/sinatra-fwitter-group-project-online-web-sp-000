class User < ActiveRecord::Base
  validates_presence_of :username, :email
  has_secure_password
  has_many :tweets

  def slug
    username.downcase.split(" ").join("-")
  end

  def self.find_by_slug(username)
      User.all.find {|u| u.slug == username}
  end
end
