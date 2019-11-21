class UsersController < ApplicationController

    post "/login" do
        if params[:username]== "" || params[:password] == ""
            redirect to '/login'
        end
      user=User.find_by(username: params[:username])
            if user && user.authenticate(params[:password])
            session[:user_id]=user.id
         redirect to '/tweets'
            else
              redirect to '/login'
            end
    end

    get "/users/:id" do
      @user=User.find_by_slug(params[:id])
      binding.pry
      erb :"/users/show"
    end

  

end
