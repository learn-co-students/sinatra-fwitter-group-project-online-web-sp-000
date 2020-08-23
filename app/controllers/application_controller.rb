require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, SecureRandom.hex(20)
  end

  get "/" do
    erb :homepage
  end

  #   Sign Up
  get "/signup" do
    erb :"/users/sign_up"
  end

  post "/signup" do
    # binding.pry
    if session[:user_id]
      redirect to("/tweets")
      
    else
      if params.any? {|k,v| v == ""}
      redirect to("/signup")
    end
    @user = User.create(params)
    session[:user_id] = @user.id
    @session = session
    redirect to("/tweets")
    end
  end


  get "/login" do
    erb :"/users/login"
  end

  post "/login" do
    @user = User.find_by_username(params[:username])
    # binding.pry

    if !!@user && !!@user.authenticate(params[:password])
      session[:user_id] = @user.id
      @session = session
      redirect to("/tweets")
    else
      redirect "/login"
    end
  end

  # Log Out
  post "/logout" do
    session.clear()
    redirect "/login"
  end


  helpers do
    def current_user
      User.find_by_id(session[:user_id])
    end

    def logged_in?
      !!session[:user_id]
    end
  end
end
