class UsersController < ApplicationController

    get '/signup' do 
        if !logged_in?
        erb :"/signup"
        else 
            redirect '/tweets'
        end 
    end
    
      post "/signup" do
        @user = User.new(username: params[:username], email: params[:email], password: params[:password])
        if @user.save && !@user.username.empty? && !@user.email.empty? && !@user.password.empty?
            session[:user_id] = @user.id
            redirect "/tweets"
        else
          redirect "/signup"
        end
      end

      get "/login" do 
        if !logged_in?
        erb :"/login"
        else 
            redirect '/tweets'
        end 
      end 

      post "/login" do 
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id 
            redirect '/tweets'
        else
            redirect '/login'
        end 
    end 

    get '/logout' do 
        if logged_in?
          session.clear
          redirect '/login'
        else
          redirect '/'
        end
      end

      get '/users/:slug' do 
        @user = User.find_by_slug(params[:slug])
        erb :"/users/show"
      end 


end
