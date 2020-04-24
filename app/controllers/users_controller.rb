class UsersController < ApplicationController

    get "/users/:slug" do 
      @user = current_user
      erb :"users/show"
    end 

    get "/signup" do 
        if logged_in? 
          redirect :"/tweets"
        end
        erb :"signup"
      end 
    
      post "/signup" do
        if params[:username] == '' || params[:email] == ''  || params[:password] == ''
          redirect :"/signup"
        else 
          @user = User.new(username: params[:username], email: params[:email], password: params[:password])
          @user.save
          
          session[:user_id] = @user.id
          redirect to "/tweets"
        end
      end
    
      get "/login" do 
        if logged_in? 
          redirect to "/tweets"
        end
        erb :"login"
      end 
    
      post "/login" do 
       
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
          session[:user_id] = @user.id
          redirect to "/tweets"
        else 
          redirect to "/signup"
        end
      end 
    
      get '/logout' do 
        if logged_in?
          redirect to "/login"
        end
        redirect to "/"
      end 
    
end
