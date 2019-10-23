class Helpers
  def self.current_user(session_hash)
    @user = User.find(session_hash[:username])
  end

  def self.logged_in?(session_hash)
    !!session_hash[:username]
  end
end
