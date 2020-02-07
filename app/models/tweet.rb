class Tweet < ActiveRecord::Base
  belongs_to :user

  def name
    User.find(self.user_id).username
  end
end
