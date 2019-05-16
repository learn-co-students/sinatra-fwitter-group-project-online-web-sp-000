require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "very secure"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    redirect "/tweets" if Helper.is_logged_in?(session)
    
    erb :'/users/create_user'
  end

  post '/signup' do
    redirect "/signup" if params[:username].empty? || params[:email].empty? || params[:password].empty?
    user = User.new(params)
    
    if user.save
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end
  
  get '/login' do
    redirect "/tweets" if Helper.is_logged_in?(session)
    
    erb :'/users/login'
  end
  
  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end
  
  get '/logout' do
    session.clear
    redirect "/login"
  end

end
