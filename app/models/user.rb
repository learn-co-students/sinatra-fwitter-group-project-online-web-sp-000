class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    self.username.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end 

  def self.find_by_slug(slug)
  
    User.all.detect do |result|
      result.slug === @slug
    end
  end

end

#slug = @user.slug
