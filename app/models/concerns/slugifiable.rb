module Slugifiable
  module ClassMethods
    def find_by_slug(slug)
      found = ""
      all.each{|inst| found =  inst if inst.slug == slug}
      found
    end
  end
  
  module InstanceMethods
    def slug
      self.username.downcase.split(" ").join("-")
    end
  end
end