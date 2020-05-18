module Slugifiable
  module InstanceMethods
    def slug
      self.username.gsub(' ', '-').downcase if self.username
    end
  end

  module ClassMethods
    def find_by_slug(slug)
      self.all.find do |result|
        result.slug == slug
      end
    end
  end
end
