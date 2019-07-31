class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    username.downcase.split(" ").join("-")
  end

  def find_by_slug(slug)
    Users.all.find {|user| user.slug == slug}
  end
end
