class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    name_slug = username.gsub(/\s/, "-")
  end

  def self.find_by_slug(slugged_name)
    username = slugged_name.gsub(/-/, " ")
    self.find_by_username(username)
  end
end
