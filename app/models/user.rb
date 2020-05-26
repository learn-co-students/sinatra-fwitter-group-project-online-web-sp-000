class User < ActiveRecord::Base
  attr_accessor :password_digest

  has_secure_password
  has_many :tweets

  #validates :username, presence: true
  #validates :email, presence: true
  #validates :password, presence: true

  def slug
    username.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    #User.all.find{|user| user.slug == slug}
    #name = slug.gsub("-"," ")
    #User.find_by(username: name)
    User.find_by_username(slug.gsub('-',' '))
  end

end
