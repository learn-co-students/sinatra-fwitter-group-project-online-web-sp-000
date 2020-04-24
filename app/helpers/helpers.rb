class Helpers
    def self.current_user(session)
      @user = User.find(session[:user_id])
    end
  
    def self.(session)is_logged_in?
      !!session[:user_id]
    end
  end 