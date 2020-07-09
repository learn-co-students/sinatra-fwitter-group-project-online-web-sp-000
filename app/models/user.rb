class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  def slug
    username.downcase.gsub(/[^0-9a-z\s]/i, '').gsub(' ', '-')
  end

  def self.find_by_slug(slug)
    User.all.find{|user| user.slug == slug}
  end
  
end
