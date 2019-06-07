class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  #TRY TO GET THIS TO WORK...
  # validates :username, :email, :password, presence: true

  #The gsub replaces spaces with hyphens, downcase makes it lowercase.
  def slug
    self.username.gsub(" ", "-").downcase
  end

  def self.find_by_slug(slug)
    self.find do |instance|
      instance.slug == slug
    end
  end
end
