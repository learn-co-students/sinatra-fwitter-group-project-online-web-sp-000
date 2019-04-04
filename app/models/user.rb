class User < ActiveRecord::Base
    has_secure_password
    has_many :tweets
    validates :username, presence: true
    validates :email, presence: true
    def slug
        self.username.gsub(" ", "-").downcase
    end

    def self.find_by_slug(slug)         
        self.all.find{|obj| obj.slug == slug}
    end
end