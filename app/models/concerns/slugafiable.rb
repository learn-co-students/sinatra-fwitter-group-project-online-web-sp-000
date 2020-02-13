module Slugafiable
  module InstanceMethods

    def slug
      username.parameterize
    end

  end

  module ClassMethods

    def find_by_slug(slug)
      self.all.detect {|i| i.username.parameterize === slug}
    end

  end

end