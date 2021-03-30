class UsersController < ApplicationController

    get "/signup" do
        erb :"users/create_user"
    end

    post "/signup" do
        @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    
        if  @user.save && !@user.username.empty? && !@user.email.empty? 
            
            session[:user_id] = @user.id

            redirect "tweets/tweets"

          else

            redirect "/signup"

        end

    end

    get "/login" do
            erb :'users/login'
    end

    post "/login" do
        #binding.pry
        @user = User.find_by(:username => params[:username])
        
        if @user && @user.authenticate(params[:password])
          session[:user_id] = @user.id

          redirect "/tweets"

        else

          redirect "/signup"

        end
    
    end

    get "/logout" do
        session.clear

        redirect "/login"
        
    end


end
