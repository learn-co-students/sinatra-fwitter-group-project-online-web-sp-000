class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    self.username.split(" ").map{|string| string.downcase}.join("-") 
  end

  def self.find_by_slug(slug)
    name = slug.split("-").map{|string| string.capitalize}.join(" ")
    self.where(
      self.arel_table[:username]
      .lower
      .matches("%#{name.downcase}%")
    ).last
  end
end
