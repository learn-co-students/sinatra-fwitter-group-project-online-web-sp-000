class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def self.find_by_slug(url_slug)
    self.all.find { |obj| obj.slug == url_slug }
  end
  
  def slug
    self.username.gsub(" ", "-").scan(/[[^\s\W]-]/).join.downcase
  end
end
