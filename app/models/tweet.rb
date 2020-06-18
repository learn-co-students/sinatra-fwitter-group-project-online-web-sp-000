class Tweet < ActiveRecord::Base
  belongs_to :user

  # def slug
  #     self.name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  # end 

  # def self.find_by_slug(slug)
    
  #   Song.all.detect do |result|
  #     result.slug === @slug
  #   end
  # end

end
