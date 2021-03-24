class User < ActiveRecord::Base
  validates :email, presence: true
  validates :username, presence: true
  validates :password, presence: true
  has_secure_password 
  has_many :tweets

# helper methods
def self.current_user(session) 
  if session[:user_id]
  user = User.find(session[:user_id]) 
  user ? user : nil
  end
end

def self.is_logged_in?(session)
   !!current_user(session)
end

#format to slug
def slug
  slug = self.username.downcase.parameterize
end
def self.find_by_slug(slug)
  @slug = slug
  format_slug_beginning
  results = self.where("username LIKE ?", @short_slug)
  results.detect do |result|
    result.slug === @slug
  end
end

def self.format_slug_beginning
  slug_beginning = @slug.split("-")[0]
  slug_beginning.prepend("%")
  slug_beginning << "%"
  @short_slug = slug_beginning
end

end
