require './config/environment'

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
    if Helper.is_logged_in?(session)
      redirect '/tweets'
    else
      erb :'/users/create_user'
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


  get '/login' do
    if Helper.is_logged_in?(session)
      redirect "/tweets"
    else
      erb :'/users/login'
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

end
