class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def valid_signup
    self.username != "" && self.email != "" && self.password_digest != nil
  end

  def slug
    self.username.downcase.gsub(/[ ]/, "-")
  end

  def self.find_by_slug(slugname)
      spaced_slugname = slugname.gsub(/[-]/, " ")
      self.all.detect do |user|
          user.username.downcase == spaced_slugname
      end
  end
end
