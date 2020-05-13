class User < ActiveRecord::Base
	validates_presence_of :username, :email, :password
  has_secure_password
  has_many :tweets

	def slug
		self.username.gsub(" ", "-").downcase
	end

	def self.find_by_slug(slug)
		self.all.find{ |i| i.slug == slug }
	end
end
