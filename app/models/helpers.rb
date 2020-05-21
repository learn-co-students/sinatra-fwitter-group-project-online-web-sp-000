class NotHelpers
    

    def self.logged_in?
      !!session[:user_id]
    end

    def self.current_user
      User.find(session[:user_id])
    end

end