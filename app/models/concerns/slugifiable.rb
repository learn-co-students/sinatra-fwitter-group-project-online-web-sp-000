module Slugifiable

  module ClassMethods
    def find_by_slug(string)
      self.all.each do |item|
        if item.slug == string
          return item
        end
      end
    end
  end

  module InstanceMethods
    def slug
      self.username.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
    end
  end

end