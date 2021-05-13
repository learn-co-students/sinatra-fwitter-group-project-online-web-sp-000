module Slugfiable
  module InstanceMethods
    def slug
      self.username.gsub(" ", "-").downcase
    end
    
    def unslug
      self.username.gsub("-", " ").downcase
    end
  end

  module ClassMethods
    def find_by_slug(slug)
      self.all.find{ |instance| instance.slug == slug }
    end
  end
end