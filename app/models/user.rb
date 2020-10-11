class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets
  
  def slug
    slug = self.username.downcase.gsub(/[^a-zA-Z0-9. ]/, "").gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    username = slug.gsub("-", " ")
        self.all.each do |obj|
            if obj.username.downcase.strip.gsub(/[^a-zA-Z0-9. ]/, "") == username
                return obj
            end
        end
  end
end
