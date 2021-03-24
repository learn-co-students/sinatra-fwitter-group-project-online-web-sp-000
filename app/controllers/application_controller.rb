require './config/environment'
# require 'rack-flash'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do  
    erb :index
  end

  get '/signup' do 
    if User.is_logged_in?(session)
      redirect "/tweets"
    end
    erb :"/users/create_user"
  end

  post '/signup' do
    if params.has_value?("")
      redirect "/signup"
    else
      @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
      session[:user_id] = @user.id
      redirect "/tweets"
    end
  end

  get '/login' do
    if !User.is_logged_in?(session)
      erb :"/users/login"
    else
      redirect "/tweets"
    end
  end

  post '/login' do
    if User.is_logged_in?(session)
      redirect "/tweets"
    else
      @user = User.find_by(:username => params[:username].strip)
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect "/tweets"
      else
        # flash[:message] = "Invalid username/password."
        redirect "/login"
      end
    end
  end

  get '/logout' do 
    if User.is_logged_in?(session)
      session.clear
      redirect "/login"
    else
      redirect "/"
    end
  end
  
end
