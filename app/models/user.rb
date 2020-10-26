class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    if self.username.include?(' ')
      self.username.gsub(' ', '-')
    else
      self.username
    end
  end

  def self.find_by_slug(slug)
    if slug.include?('-')
      User.find_by(:username => slug.gsub('-', ' '))
    else
      slug
    end
  end

end
