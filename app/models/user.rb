class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets
<<<<<<< HEAD
  
  def slug
    self.username.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end
  def self.find_by_slug(slug)
=======

  def slug
    self.username.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end 

  def self.find_by_slug(slug)
  
>>>>>>> 6265492469202805c30fcd2243607474289ef005
    User.all.detect do |result|
      result.slug === @slug
    end
  end

end

#slug = @user.slug
