module Slugifiable
  
  module ClassMethods
  	def find_by_slug(slug)
      self.all.find do |s|
        self.find_by username: s.username if (s.username.parameterize == slug)
      end
  	end
  end

  module InstanceMethods
  	def slug
      username.parameterize
  	end  
  end
end