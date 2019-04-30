class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  def slug
    return self.username.downcase.gsub(' ','-').gsub(/[^\w-]/,'')
  end

  def self.find_by_slug(text)
    self.all.detect {|user| user.slug == text}
  end
end
