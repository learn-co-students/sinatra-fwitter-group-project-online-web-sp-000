module Slugifiable

  module InstanceMethods
    def slug
      self.username.downcase.gsub(" ", "-")
    end
  end

  module ClassMethods
    def find_by_slug(params_slug)
      self.find {|object| object.slug == params_slug}
    end
  end

end