module Slugifiable
    module ClassMethods
        def find_by_slug(slug)
            self.all.detect {|i| i.slug == slug}
        end
    end

    module InstanceMethods
        def slug
            holder_name = self.name
            slug = holder_name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
        end
    end
end