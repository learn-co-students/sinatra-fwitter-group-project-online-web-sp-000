
module Slugify

    module InstanceMethod
        def slug
            self.username.downcase.gsub(" ", "-")
        end
    end

    module ClassMethod
        def find_by_slug(slug)
            self.all.find {|user| user.slug == slug}
        end
    end

end