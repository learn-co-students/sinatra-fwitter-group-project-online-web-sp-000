class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    @slug = self.username.parameterize
    @slug
  end

  def self.find_by_slug(slug)
    @user = User.all.find do |user|
        user.slug == slug
    end
    @user     
  end

end
