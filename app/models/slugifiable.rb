module Slugifiable
  module InstanceMethods
    def slug
      self.username.split(" ").join("-")
    end
  end

  module ClassMethods
    def find_by_slug(slug)
      user_name = slug.split("-").join(" ")
      self.find_by(username: user_name)
    end
  end
end
