require 'rack-flash'
require 'sinatra/base'

class UsersController < ApplicationController
    enable :sessions
    use Rack::Flash
    register Sinatra::ActiveRecordExtension
    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
        enable :sessions
        set :session_secret, "secret"
    end

    get '/login' do
        if Helpers.is_logged_in?(session)
            redirect to '/tweets'
        end
      
        erb :'/users/login'
    end

    post '/login' do
        user = User.find_by(:username => params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect to '/tweets'
        else
            flash[:message] = "Incorrect login. Please try again."
            redirect to '/login'
        end
    end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb:'/users/show'
    end

    get '/logout' do
        if Helpers.is_logged_in?(session)
            session.clear
            redirect to '/login'
        else
            redirect to '/'
        end
    end
end
