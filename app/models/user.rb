class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  def slug
    self.username.gsub(' ', '-').downcase if self.username
  end

  def self.find_by_slug(slug)
    self.all.find do |result|
      result.slug == slug
    end
  end

end
