module Helpers 
    #returns a boolean if the user is logged in 
    module InstanceMethods
      def logged_in?
          !!session[:user_id]
      end
    end

    module ClassMethods
      #keeps track of the logged in user
      def current_user
          User.find_by(id: session[:user_id])
      end
    end

end
