
class Helpers
  def self.current_user(session)
    User.find_by(:id => session[:user_id])
  end

  def self.logged_in?(session)
    !!User.find_by(:id => session[:user_id])
  end
end
