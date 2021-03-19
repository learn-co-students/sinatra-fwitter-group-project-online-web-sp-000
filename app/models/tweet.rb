class Tweet < ActiveRecord::Base
  belongs_to :user
  #set :method_override, true
end
