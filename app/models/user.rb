class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  has_secure_password

  def slug
    username.downcase.gsub(" ","-")
  end

end
