class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    slug = username.downcase.gsub(' ', '-')
    slug
  end

  def self.find_by_slug(slug)
    the_user = nil
    all.each do |u|
      if u.slug == slug 
        the_user = u 
      end 
    end
    the_user
  end
end
