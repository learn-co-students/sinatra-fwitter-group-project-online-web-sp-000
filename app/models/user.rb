class User < ActiveRecord::Base
  has_secure_password
  validates_presence_of :username, :email
  has_many :tweets

  def slug
    slug = self.username.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end

  def self.find_by_slug(slug)
      self.all.find {|t| t.slug === slug}
  end
end