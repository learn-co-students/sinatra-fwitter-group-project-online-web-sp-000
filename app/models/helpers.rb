class Helpers
    def self.is_logged_in?(session)
        if  session[:user_id] != nil
            true
        end
    end
end