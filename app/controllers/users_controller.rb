class UsersController < ApplicationController
    
    get '/' do
        erb :'users/index'
    end
    
    get "/signup" do
        if !logged_in?
            erb :'/users/signup'
        else
            redirect '/tweets'
        end
    end
    
    post "/signup" do
    
        if params[:username] == "" || params[:password] == "" || params[:email] == ""
            redirect '/signup'
        else
            @user = User.create(username: params[:username], email: params[:email], password: params[:password])
            session[:user_id] = @user.id 
            redirect '/tweets'
        end
    end
    
      get "/login" do
        if !logged_in?
            erb :'users/login'
        else
            redirect '/tweets'
        end
      end
    
      post "/login" do
        user = User.find_by(username: params[:username])
    
        if user && user.authenticate(params[:password])
          session[:user_id] = user.id 
          redirect "/tweets"
        else
          redirect "/failure"
        end
      end
    
      get "/failure" do
        erb :'users/failure'
      end
    
      get "/logout" do
        if logged_in?
            session.clear
            redirect "/login"
        else
            redirect '/'
        end
      end
    
      get "/users/:slug" do
        @user = User.find_by_slug(params[:slug])

        erb :'users/show_user'
    end



end
