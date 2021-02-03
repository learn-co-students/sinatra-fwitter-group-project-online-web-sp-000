class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
      if self.username.gsub!(/[^0-9A-Za-z ]/, '')
          self.username.split(" ").join("-").downcase
      else
          self.username.split(" ").join("-").downcase
      end
  end

  def self.find_by_slug(slug)
      self.all.find { |user| user.slug == slug}
  end
end