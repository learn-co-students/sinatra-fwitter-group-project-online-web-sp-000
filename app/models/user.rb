class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets
  
  def slug
    @slug = self.username.gsub(" ", "-")
  end
  
  def self.find_by_slug(slug)
    @user = nil
    self.all.each do |user|
      if user.slug == slug
        @user = user
      end
    end
    @user
  end
  
end
