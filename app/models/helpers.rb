class Helpers

    def self.is_logged_in?(session)
        if session[:user_id]
            true
        else
            false
        end
    end

    def self.current_user(session)
        User.find(session[:user_id])
    end

end