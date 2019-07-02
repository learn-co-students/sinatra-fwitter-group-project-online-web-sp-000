module Slugifiable

    def slug
      #replace spaces with -
      self.username.downcase.gsub(" ", "-")
      
    end

    def find_by_slug(slug)
      self.all.find{ |object| object.slug == slug}
    end
end