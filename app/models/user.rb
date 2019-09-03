class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
#convert the username into a slug, subsitute emoty space for dashes
  username = self.username
  slug = username.downcase.strip.gsub(' ', '-')
  end

  def find_by_slug(slug)
#should fid the user whos slug is equal whatever slug is passed in as a arguement
  @slug = slug
  format_slug_beginning
  results = self.where("username LIKE ?", @slug)
  results.detect do |result|
    results.slug === @slug
  end
end


end
