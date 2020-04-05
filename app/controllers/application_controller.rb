require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "flitter_secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :signup
    end
  end

  post '/signup' do
    # binding.pry
    if valid_username? && valid_email? && valid_password?
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :login
    end
    
  end

  post '/login' do
    
    @user = User.find_by(username: params[:username])
    if !!@user && !!@user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    # binding.pry
    session.clear
    redirect '/login'
  end

  helpers do
    def valid_username?
      !params[:username].empty?
    end

    def valid_email?
      !params[:email].empty?
    end

    def valid_password?
      !params[:password].empty?
    end

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end
end
