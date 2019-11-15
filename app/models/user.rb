class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
     self.username.gsub(/ /, '-').downcase
  end

  def self.find_by_slug(slug)
    user_name = slug.gsub(/-/, ' ')
    User.all.each do |user|
      if user.username.downcase == user_name
        @user = user
      end
    end
    @user
  end

end

class Helpers < ActiveRecord::Base

  def self.current_user(user)
    @user = User.find_by(id: user[:user_id])
  end

  def self.is_logged_in?(user)
    if user[:user_id]
      true
    else
      false
    end
  end

end
