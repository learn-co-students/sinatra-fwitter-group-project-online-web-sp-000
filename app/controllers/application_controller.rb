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
    if Helpers.is_logged_in?(session)
      redirect to '/tweets'
    else
      erb :"/users/create_user"
    end
  end

  post '/signup'do
    #binding.pry
    if Helpers.empty_input?(params)
      redirect to '/signup'
    else
      @user=User.create(params)
      session[:user_id]=@user.id
      redirect to '/tweets'
    end
  end

  get '/login' do
    #binding.pry
    if Helpers.is_logged_in?(session)
      redirect '/tweets'
    else
      erb :"/users/login"
    end
  end

  post '/login' do
    #binding.pry
    @user=User.find_by(:username=>params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id]=@user.id
      redirect to '/tweets'
    else
      redirect to "/login"
    end
  end

  get '/logout' do
    if Helpers.is_logged_in?(session)
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end
