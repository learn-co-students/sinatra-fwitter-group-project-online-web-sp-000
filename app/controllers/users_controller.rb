require 'rack-flash'

class UsersController < ApplicationController
    enable :sessions
    use Rack::Flash

    get '/signup' do
        if !logged_in?
            erb :'users/signup'
        else
            redirect to '/tweets/index'
        end
    end

    post '/signup' do

        if !User.find_by(:email => params[:email]) && params[:username] != "" && params[:email] != "" && params[:password] != "" && !User.logged_in?
            @user = User.create(params)
            redirect to '/tweets/index'
        else
            redirect to '/signup'
            flash[:message] = "This email is already associated with an account. Please login."
        end
        
    end

    get '/login' do
        erb :'users/login'
    end

    post '/login' do
        @user = User.find_by(:username => params[:username])

        if @user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect '/tweets/index'
        else
            redirect to "/login"
            flash[:message] = "This username or password is incorrect."
        end
    end


    helpers do
        def logged_in?
          !!session[:user_id]
        end
    
        def current_user
          User.find(session[:user_id])
        end
      end

end
