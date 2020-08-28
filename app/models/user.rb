class User < ActiveRecord::Base 
  has_secure_password
  has_many :tweets


  def slug  
    username = self.username.downcase
    username.gsub(/\s/,'-')
 end

 def self.find_by_slug(slug)
   username =  slug.gsub("-"," ")
    item  = nil
    self.all.each{|s|
    if s.username.downcase == username
      item =  s
    end
}
   item
 end
 
end
