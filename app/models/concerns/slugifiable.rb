module Slugifiable
  module InstanceMethods
    def slug
      username.downcase.strip.gsub(' ','-')
    end
  end

  module ClassMethods
    def find_by_slug (input_slug)
      all.find { |object| object.slug == input_slug }
    end
  end
end
