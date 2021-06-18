module Slugifiable
  module InstanceMethods
    def slug
      self.username.gsub(" ", "-").downcase
    end
  end

  module ClassMethods
    def find_by_slug(slug)
      self.all.detect do |s|
        s.username.downcase == slug.gsub("-", " ")
      end
    end
  end
end
  