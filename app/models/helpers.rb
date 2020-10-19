module Helpers

    module InstanceMethod
        def logged_in?
            !!current_user
        end
    end

    module ClassMethod
        def current_user
            User.find_by(id: session[:user_id])
        end
    end

end