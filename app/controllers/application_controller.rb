require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "coolright"
  end


  get '/' do
    erb :index
  end

  get '/signup' do
    if is_logged_in?(session)
      redirect '/tweets'
    else
      erb :'/users/create_user'
    end
  end

  get '/login' do
    if is_logged_in?(session)
      redirect "/tweets"
    else
      erb :'/users/login'
    end
  end

  post '/signup' do
    user = User.new(params)
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect "/signup"
    elsif user.save
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
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


  helpers do
    def current_user(session)
      User.find(session[:user_id])
    end

    def is_logged_in?(session)
      session.include?(:user_id)
    end
  end

end
