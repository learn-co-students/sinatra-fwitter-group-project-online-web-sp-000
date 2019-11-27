class Helpers

  def self.current_user(session)
    if session[:user_id] != nil
      User.find(session[:user_id])
    end
  end

  def self.logged_in?(session)
    if session[:user_id] != nil
      user_id = current_user(session).id
      session[:user_id] == user_id ? true : false
    end
  end

  def self.current_tweet(id)
    Tweet.find(id)
  end

end
