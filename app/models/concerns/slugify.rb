module Concerns

  module InstanceMethods

    def slug
      self.username.downcase.gsub(/[^\w\d\s]/, "").gsub(/[\s]/, "-")
    end

  end

  module ClassMethods

    def find_by_slug(slug)
      self.all.detect{|obj| obj.slug == slug}
    end

  end
end
