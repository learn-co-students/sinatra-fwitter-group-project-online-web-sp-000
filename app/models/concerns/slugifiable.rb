module Slugifiable

    module ClassMethods
        def find_by_slug(slug)
            deslug = slug.split("-").join(" ")
            self.find_by(username: deslug)
        end
    end

    module InstanceMethods
        def slug
            slug = self.username.split(" ").join("-")
            slug
        end
    end

end