module Slugifiable
    module InstanceMethod
      def slug
          self.username.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
       end
    end
    
    module ClassMethod
      def find_by_slug(slug)
         self.all.find{|a| a.slug == slug}
      end
    end
end