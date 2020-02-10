class User < ActiveRecord::Base
  # validates :email, uniqueness: true
  #
  # validates :username, uniqueness: true
  # Validates :password, presence: true
  validates :email,:username,:password, :presence => true
  validates :email,:username, :uniqueness => true
  validates :email,:username, :uniqueness => { case_sensitive: false }
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  has_secure_password
  has_many :tweets

  def slug
    username.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    User.all.find{|user| user.slug == slug}
  end
end
