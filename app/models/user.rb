class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets
  validates_presence_of :username, :email, :password

  def slug
    self.username.downcase.gsub(' ', '-')
  end

  def self.find_by_slug(slug)
    self.all.detect {|x| x.slug == slug}
  end
end
