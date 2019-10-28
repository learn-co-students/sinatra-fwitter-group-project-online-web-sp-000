require 'pry'
class Tweet < ActiveRecord::Base
  belongs_to :user

  def slug(text)
    @text = text 
     binding.pry 
  end 



end
