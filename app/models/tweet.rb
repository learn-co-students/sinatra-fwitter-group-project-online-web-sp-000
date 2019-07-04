class Tweet < ActiveRecord::Base
  belongs_to :user

  def author
    self.user
  end

  def author_name
    self.user.username
  end

end
