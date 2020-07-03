class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    title = self.username
    slug = title.downcase
    slug.tr!(" ", "-")
    slug.gsub!(/[^a-zA-Z\d-]/, "")
    slug
  end

  def self.find_by_slug(slug)
    self.all.select {|item| item.slug == slug}.first
  end

end
