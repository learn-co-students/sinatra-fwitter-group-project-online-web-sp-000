class UsersController < ApplicationController

    get '/login' do
        if logged_in?
            redirect '/tweets'
        else
          erb :'/users/login'
        end
    end

    post '/login' do
      user = User.find_by(:username => params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id]=user.id
        redirect '/tweets'
      else 
        redirect '/login'
      end
    end
    
    
    get "/users/:slug" do
        @user = User.find_by_slug(params[:slug])
        erb :'/users/show'
    end

    get '/signup' do
        if logged_in?
            redirect '/tweets'
        else
           erb :'/users/create_user'
        end
    end

    post '/signup' do
        @user=User.create(params)
        if @user.save
            session[:user_id]=@user.id
            redirect "/tweets"
        else
            redirect '/signup'
        end
    end

    get "/logout" do
        session.clear
        redirect "/login"
    end
end
