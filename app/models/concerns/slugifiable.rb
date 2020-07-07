
module Slugifiable

  module InstanceMethods

    def self.included(base)
      base.extend(ClassMethods)
    end

    def slug
      username.downcase.gsub(" ", "-")
    end

  end

  module ClassMethods
    def find_by_slug(slug)
      self.all.find {|artist| artist.slug == slug}
    end
  end

end