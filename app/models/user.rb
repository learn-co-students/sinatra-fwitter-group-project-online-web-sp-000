class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
convert the username into a slug, subsitute emoty space for dashes
  end

  def find_by_slug()
should fid the user whos slug is equal whatever slug is passed in as a arguement
  end
end
