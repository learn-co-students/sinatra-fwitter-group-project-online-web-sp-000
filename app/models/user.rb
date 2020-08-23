class User < ActiveRecord::Base
  before_create :slug
  has_secure_password
  has_many :tweets

  def slug
    self.slug = self.username.downcase.split(" ").join("-")
  end
end
