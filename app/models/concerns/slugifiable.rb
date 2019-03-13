module Slugifiable

  def slug
    self.username.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end

  def find_by_slug(slug)
    unslug = slug.gsub('-', ' ')
    self.find_by(:username => unslug)
  end

end
