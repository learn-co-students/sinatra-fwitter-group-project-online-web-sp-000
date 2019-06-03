require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if session[:user_id]
      redirect '/tweets'
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    if User.create(params).valid?
      @user = User.last
      session[:user_id] = @user.id

      if logged_in?
        redirect '/tweets'
      else
        redirect '/signup'
      end
    else
        redirect '/signup'
    end

  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :"/users/login"
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect '/login'
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
