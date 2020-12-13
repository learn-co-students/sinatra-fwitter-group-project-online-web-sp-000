class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets
  validates :username, presence: true
  validates :email, presence: true

  def slug
    self.username.downcase.tr(" ","-")
  end

  def self.find_by_slug(slug)
    self.all.find do |instance|
      instance.slug == slug
    end
  end
end