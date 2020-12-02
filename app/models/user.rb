
module Slugifiable
  module InstanceMethods
      def slug
          self.username.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
      end
  end

  module ClassMethods
      def find_by_slug(slug)
          search_slug = slug.gsub('-', ' ')
          self.where("username LIKE ?", "%#{search_slug}%").first
      end
  end
end

class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets
  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods
end
