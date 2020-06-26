class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    self.username.downcase.split.join("-")
  end

   def User.find_by_slug(slug)
    user=slug.gsub('-', ' ')
    user= User.where("username like ?", "%#{user}%").take 
   end

   
   

end
