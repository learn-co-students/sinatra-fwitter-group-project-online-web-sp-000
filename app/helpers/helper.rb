class Helper
  def self.current_user(session)
    User.find(session[:user_id])
  end

  def self.is_logged_in?(session)
    session.include?(:user_id)
  end
end
