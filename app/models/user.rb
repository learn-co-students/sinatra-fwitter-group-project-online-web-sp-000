class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    self.username.gsub(/ /, '-').downcase
  end

  def self.find_by_slug(name)
    deslug = name.gsub(/-/, ' ')
    user = User.find_by(:username => deslug)
    user
  end
end