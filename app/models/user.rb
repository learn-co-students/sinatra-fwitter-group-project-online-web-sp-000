class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    self.username.gsub(" ","-").downcase
  end

  def self.find_by_slug(arg)
      username=arg.gsub("-", " ")
      self.find {|username| username.slug==arg}
      # binding.pry
      # self
  end
end
