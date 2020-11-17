class Tweet < ActiveRecord::Base
  belongs_to :user

  validates :content, presence: true 


  def slug
    self.name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
end

def self.find_by_slug(slugx)
    tweet=Tweet.all
    slugged = Tweet.all.find_index do |tweet|
        tweet.slug == slugx
    end
    tweet[slugged]
end
end
