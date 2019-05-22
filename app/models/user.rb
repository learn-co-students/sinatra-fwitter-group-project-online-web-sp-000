class User < ActiveRecord::Base
  has_many :boxes
  has_many :items, through :boxes
  has_secure_password

  def slug
    self.username.gsub(" ", "-").downcase
  end

  def self.find_by_slug(slug)
    self.all.each do |s|
        break s if slug == s.slug
    end
  end
end
