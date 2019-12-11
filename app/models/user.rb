class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    self.username.split(" ").join("-").downcase
  end

  def self.find_by_slug(slug)
    self.all.find do |o|
      split_name = o.username.split(" ")
      slugged = split_name.join("-")
      slugged.downcase!
      slugged == slug
    end
  end
end
