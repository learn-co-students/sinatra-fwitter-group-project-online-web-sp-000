module Slugifiable
    module InstanceMethods
        def slug
            username.downcase.strip.gsub(' ','-')
        end
    end

    module ClassMethods
        def find_by_slug(slug)
            all.detect {|e| e.slug == slug}
        end
    end
end