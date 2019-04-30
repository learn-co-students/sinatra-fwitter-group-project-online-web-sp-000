require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "secret"
    enable :sessions
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
    user = User.new(params)

    if user.save && user.username != "" && user.email != ""
      # binding.pry
      session[:user_id] = user.id
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
    user = User.find_by(username:params[:username])
    if user && user.authenticate(params[:password])
      # binding.pry
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect 'login'
    end
  end

  get '/logout' do
    if logged_in?
      session[:user_id] = nil
    end
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
