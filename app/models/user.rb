class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

def slug
    self.username.ljust(100).strip.gsub(/[\s\t\r\n\f]/,'-').gsub(/\W/,'-').downcase
end

def self.find_by_slug(slug)
    self.find {|i| i.slug == slug}
end

end
