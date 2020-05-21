module Slugifiable
    def self.included(klass)
      klass.extend(ClassMethods)
    end
  
    module ClassMethods
      def find_by_slug(slug)
        self.find {|u| u.slug == slug}
      end
  
    end
  
    def slug
      self.username.parameterize
    end

  end