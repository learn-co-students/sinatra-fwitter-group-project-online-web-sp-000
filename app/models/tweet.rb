class Tweet < ActiveRecord::Base

  extend Slugify::ClassMethods
  include Slugify::InstanceMethods
  extend Helpers::ClassMethods
  include Helpers::InstanceMethods
  
    belongs_to :user
    
    validates :content, presence: true
    
end
