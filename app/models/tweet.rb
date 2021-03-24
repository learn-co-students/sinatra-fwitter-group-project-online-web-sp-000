class Tweet < ActiveRecord::Base
  validates :content, presence: true
  validates :user_id, presence: true
  belongs_to :user
end
