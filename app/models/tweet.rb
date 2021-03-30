class Tweet < ActiveRecord::Base
  validates_presence_of :content
  belongs_to :user

  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods
end
