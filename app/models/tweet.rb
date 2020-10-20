class Tweet < ActiveRecord::Base
  validates :content, presence: true # same as validates_presence_of :content
  belongs_to :user
end
