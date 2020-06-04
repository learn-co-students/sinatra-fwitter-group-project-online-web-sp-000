module Helpers
    module ClassMethods
        def current_user(session)
            @user = User.find(session[:user_id])
        end

        def logged_in?(session)
            !!session[:user_id]
        end
    end
    module InstanceMethods
        def slug
          self.name.downcase.gsub(" ", "-")
        end
    end
end