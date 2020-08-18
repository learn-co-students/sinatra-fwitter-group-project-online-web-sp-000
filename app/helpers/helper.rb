class Helper

  def self.current_user(session_hash)
    if session_hash[:user_id] == ""
      nil
    else
      User.find(session_hash[:user_id])
    end
  end

  def self.is_logged_in?(session_hash)
    if session_hash[:user_id] == ""
      nil
    else
      true
    end
  end
end
