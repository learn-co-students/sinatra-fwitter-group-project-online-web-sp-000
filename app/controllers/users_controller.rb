class UsersController < ApplicationController

    post "/sessions/login" do
        if params[:email]== "" || params[:password] == ""
            redirect to '/login'
          else
         redirect '/tweets'
          end
    end

end
