class Tweet < ActiveRecord::Base
  belongs_to :user

  def slug
    self.name.downcase.strip.gsub(' ', '-')
  end

  def self.find_by_slug(slug)
      self.all.find{|object| object.slug == slug}
  end

end
