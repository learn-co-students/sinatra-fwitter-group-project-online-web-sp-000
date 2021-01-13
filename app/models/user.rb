class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    self.username.tr(" ", "-")
  end

  def self.find_by_slug(slug)
    User.all.each do | sel |
      if (sel.slug == slug)
        return sel
      end
    end
  end

end
