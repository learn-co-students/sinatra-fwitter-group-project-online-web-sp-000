require './config/environment'

class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension  

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "fwitter_secret"
  end

  enable :method_override
  enable :sessions

  get '/' do
    erb :'index'
  end

  get '/signup' do
    if logged_in?(session)
      redirect to "/tweets"
    else
    erb :'/users/signup'
    end
  end

  post '/signup' do
    # binding.pry
    if params["email"] == "" || params["username"] == "" || params["password"] == ""
        redirect to "/signup"
    else
        @user = User.new(:email => params["email"], :username => params["username"], :password => params["password"])
        @user.save
        session[:user_id] = @user.id
        redirect to "/tweets"
    end
  end

  get '/login' do
    if logged_in?(session)
        current_user(session)
        redirect to "/tweets"
    else
        erb :'users/login'
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect "/tweets"
    else
        redirect "/login"
    end
  end

  get '/logout' do
    if logged_in?(session)
    session.clear
    end
    redirect "/login"
  end

  helpers do
    def current_user(session)
      if session[:id] != nil
        User.find(session[:id])
      end
    end

    def logged_in?(session)
      if session[:id] != nil
        user_id = current_user(session).id
        session[:id] == user_id ? true : false
      end
    end

    def current_tweet(id)
      Tweet.find(id)
    end
  end
end
