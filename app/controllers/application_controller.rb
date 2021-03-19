require './config/environment'

class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension  

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "fwitter_secret"
    enable :sessions
  end

  enable :method_override

  get '/' do
    erb :'index'
  end

  get '/signup' do
    # binding.pry
    if logged_in?(session)
      redirect to "/tweets"
    else
    erb :'users/create_user'
    end
  end

  post '/signup' do # sign up and check our params hash via browser.
    #binding.pry
    if params["email"] == "" || params["username"] == "" || params["password"] == ""
      redirect to "/signup"
    else
      @user = User.new(:email => params["email"], :username => params["username"], :password => params["password"])
      @user.save
      session[:user_id] = @user.id
      redirect to "/tweets"
    end
  end

  get '/login' do # if curent_user is logged in when trying to visit '/login' redirect them to "/tweets", else render :'users/login'
    if current_user(session)
    #binding.pry
      redirect to "/tweets"
    else
      erb :'users/login'
    end
  end

  post '/login' do # associate instance variable with a User who's user_id matches the :user_id key within params
    # binding.pry
    user = User.find_by(:username => params[:username]) # if the instance variable persists and the :password key in params hash authenticates
    # binding.pry
    if user && user.authenticate(params[:password]) # associate the :user_id key within our session hash with the id of our User instance
    # binding.pry
      session[:user_id] = user.id
      redirect to "/tweets"
    else
      redirect to "/signup"
    end
  end

  get '/logout' do
    if logged_in?(session)
    #binding.pry
      session.clear
      redirect to "/login"
    else
      redirect to "/"
    end
  end

  helpers do # if user is logged in, associate instance variable @user with a User that we find by :user_id key within session hash, else return nil.
    def current_user(session) # 
      if logged_in?(session)
        @user = User.find_by_id(session[:user_id])
      else
        return nil
      end
    end

    def logged_in?(session)
      if session[:user_id]
        User.find_by_id(session[:user_id])
      else
        return nil
      end
    end

    def current_tweet(id)
      Tweet.find_by_id(params[:id])
    end
  end
end
