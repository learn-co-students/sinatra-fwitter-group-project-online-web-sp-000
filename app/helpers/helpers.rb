class Helpers < ActiveRecord::Base
    def self.current_user(session)
        # user = User.find_by(id: session[:user_id])
        User.find(session[:user_id]) if session[:user_id]
    end

    def self.is_logged_in?(session)
        if current_user(session) == nil
            false
        elsif current_user(session).id == session[:user_id]
            true
        end
    end

end


    #   def self.is_logged_in?(session)
    #     if current_user(session).id == session[:user_id]
    #         true
    #     end
        
    # end
    # def self.is_logged_in?
    #     !current_user.nil?
    #    end
   
    #  def self.current_user
    #   @current_user ||= User.find_by(id: session[:user_id])
    #  end


