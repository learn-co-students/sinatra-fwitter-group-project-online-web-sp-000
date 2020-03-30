module Helpers
  def self.is_logged_in?(session)
    session[:user_id] ? true : false
  end
end
