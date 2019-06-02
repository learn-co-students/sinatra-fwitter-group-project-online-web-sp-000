class User < ActiveRecord::Base

  def slug
    self.username.split.join("-")
  end

end
