class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true
  validates :email, presence: true


  def slug
    self.username.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    User.all.detect do |user|
      if user.slug == slug
        return user
      end
    end
  end


end
