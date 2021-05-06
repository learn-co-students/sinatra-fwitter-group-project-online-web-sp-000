class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets


  def slug
    self.username.gsub(/\W/x, '-')
  end

  def self.find_by_slug(user_name)
      self.all.detect{|user| user.slug == user_name}
  end

end
