class TweetsController::Helpers
  def self.is_logged_in?(session)
    session[:id]
  end
end
