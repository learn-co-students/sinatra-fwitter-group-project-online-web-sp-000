class Helpers
    def self.current_user(session)
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
        # User.find(session[:user_id]) ## Not preferred
    end

    def self.is_logged_in?(session)
        !!current_user(session)
        # !!session[:user_id] ## Not preferred
    end
end