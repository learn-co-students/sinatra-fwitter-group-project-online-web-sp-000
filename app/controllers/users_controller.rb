class UsersController < ApplicationController

    get "/users/login" do
        erb:"/users/login"
    end
    get "/users/logout" do
        erb:"/users/logout"
    end

    get "/users/signup" do
        erb:"/users/signup"
    end

    post "/users/signup" do
   
        if User.find_by(username:params[:user][:username])
            redirect to("/users/signup")
        else
          @user = User.create(params[:user])
          session[:user_id] = @user.id
          redirect to("/tweets")
        end
    end

    post "/users/login" do
        
        @user = User.find_by(username:params[:user][:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            erb:"/tweets"
        else
         redirect to("/users/failure")
        end

    
    end

    post'/users/logout' do
        session.clear
        redirect '/'
      end
    

    get "/users/failure" do
        erb:"/users/login"
    end

end
