require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    erb :welcome
  end

  get '/signup' do
    if session[:user_id]
      redirect "/tweets"
    else
      erb :signup
    end
  end

  get '/login' do
    if Helpers.is_logged_in?(session)
      redirect "/tweets"
    else
      erb :login
    end
  end

  get '/logout' do
    session.clear
    redirect "/login"
  end

  post '/signup' do
    user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
    if user.save
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  post '/logout' do
    session.clear
    redirect "/login"
  end

  
end
