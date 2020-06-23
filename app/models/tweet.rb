class Tweet < ActiveRecord::Base

  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods

  belongs_to :user
end
