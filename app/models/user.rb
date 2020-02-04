class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    slug = self.username.downcase
    if slug.split(" ")
      slug.gsub!(/\s/,"-")
    end
  end

  def self.find_by_slug(slug)
    #binding.pry
    from_slug = slug.gsub!(/[-]/, " ")
    self.find_by(username: from_slug)
  end

end
