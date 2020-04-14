require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'

    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    erb :'index'
  end

  get '/signup' do

    if logged_in?
      redirect '/tweets'
    else
      erb :'signup'
    end
  end

  post '/signup' do

    user = User.new(:username => params[:username], :password => params[:password], :email => params[:email])

    if params[:username] == "" or params[:email] == "" or params[:password] == ""
      redirect "/signup"
    else
      user.save
      redirect '/tweets'
	  end
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
