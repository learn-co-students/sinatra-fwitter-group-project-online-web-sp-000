  module Slugifiable 
   
    module InstanceMethod 
        def slug 
            string = self.username
            string.parameterize
        end
    end

    module ClassMethod 
        def find_by_slug(slug)
            self.all.find {|string| string.slug == slug} 
        end
    end

end