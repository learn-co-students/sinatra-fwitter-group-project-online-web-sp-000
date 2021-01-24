class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true
  validates :password, presence: true

  def self.find_by_slug(string)
    self.all.each do |item|
      if item.slug == string
        return item
      end
    end
  end

  def slug
    self.username.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end

end
