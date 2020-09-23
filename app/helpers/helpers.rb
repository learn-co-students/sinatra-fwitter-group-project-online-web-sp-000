class Helpers

    def self.current_user(session)

        # self.is_logged_in?(session) ? User.all.find{|user| user.id == session[:user_id]} : nil
        User.all.find{|user| user.id == session[:user_id]}
    end 

    def self.is_logged_in?(session)
        !!session[:user_id]
    end 

end