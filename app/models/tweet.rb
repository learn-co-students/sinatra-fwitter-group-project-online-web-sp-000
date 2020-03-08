class Tweet < ActiveRecord::Base
  belongs_to :user

  def self.tweets_by_user(user)
    self.all.select {|tweet| tweet.user_id == user.id}
  end
end
