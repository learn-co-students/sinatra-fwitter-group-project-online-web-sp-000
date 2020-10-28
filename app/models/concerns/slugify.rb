module Slugify

    module InstanceMethods
        def slug
            slug = self.username.downcase.gsub(" ", "-")  
        end
    end
    
    module ClassMethods
        def find_by_slug(slug)
            self.all.find {|user| user.slug == slug}
        end 
    end      
    
end
