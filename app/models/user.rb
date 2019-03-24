class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    username.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    username = slug.gsub("-"," ").downcase
    self.all.find {|user| user.username.downcase == username}
  end

end
