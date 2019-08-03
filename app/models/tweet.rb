class Tweet < ActiveRecord::Base
  belongs_to :user

  include Slugs
end
