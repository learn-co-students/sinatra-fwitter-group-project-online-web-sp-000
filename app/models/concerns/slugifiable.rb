module Slugifiable

  module InstanceMethods
    def slug
      username.downcase.gsub(' ','-').gsub(/[^\d\w]\s+/,'-').gsub(/[^\d\w-]+/,'') unless !self.username
    end
  end 

  module ClassMethods
    def find_by_slug(slug)
      self.all.each do |item|
        return item if item.slug == slug.downcase.gsub(' ','-').gsub(/[^\d\w]\s+/,'-').gsub(/[^\d\w-]+/,'')
      end
      return nil
    end
  end
end