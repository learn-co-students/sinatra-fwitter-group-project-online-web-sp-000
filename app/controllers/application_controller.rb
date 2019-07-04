require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "secret"
  end


  get '/' do
    erb :index
  end

  helpers do

    def current_user
      @current_user ||= User.find_by(email: session[:email]) if session[:email]
    end

    def logged_in?
      !!current_user
    end

    def login(params)
      user = User.find_by(username: params[:username])
      if  !!user && user.authenticate(params[:password])
        session[:email] = user.email
      end
    end

    def logout
      @current_user = nil
      session.clear
    end

  end


end
