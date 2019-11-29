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
    # stuff I've add below
    enable :sessions
    set :session_secret, "fwitter-secret"
    # end of add stuff
  end

  get '/' do
    if logged_in?
      @tweets = Tweet.all
      @user = current_user
      erb :"/users/index"
    else
      redirect 'users/login'
    end
  end

  get '/signup' do
    if logged_in?
      erb :"/tweets"
    else
      erb :"/users/signup"
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
    puts params
      redirect "/signup"
    else
      User.create(:username => params[:username], :email => params[:email], :password => params[:password])
      redirect "/tweets"
    end
  end


  helpers do
    def logged_in?
      session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

end
