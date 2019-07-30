class User < ActiveRecord::Base
  has_many :tweets

  validates_presence_of :username, :email

  has_secure_password
  validates_presence_of :password

  def slug
    self.username.gsub(' ', '-').downcase
  end

  def self.find_by_slug(slug)
    self.where("lower(username) =?", slug.split('-').join(' ')).first
  end
end
