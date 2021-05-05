class User < ActiveRecord::Base
  has_secure_password
  validates_presence_of :username, :email
  has_many :tweets

  def slug
    self.username.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end

  def self.find_by_slug(slug)
    match = nil
    self.all.each do |a|
      if a.slug == slug
        match = a
      end
    end
    match
  end
end
