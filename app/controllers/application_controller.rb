require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "skldjflgsdlfkslkdflksdmflklksdmlfm4l54lk5dfvkdmfvm"
    # set :session_secret, SecureRandom.hex(20)
  end

  get "/" do
    if logged_in?
      redirect to("/tweets")
    else
      erb :homepage
    end
  end

  #   Sign Up
  get "/signup" do
    if !logged_in?
      erb :"/users/sign_up"
    else
      redirect "/tweets"
    end
  end

  post "/signup" do
    if params.any? {|k,v| v == ""}
      redirect to("/signup")
    end

    @user = User.create(params)
    session[:user_id] = @user.id

    @session = session

    redirect to("/tweets")
  end


  get "/login" do
    if logged_in?
      redirect "/tweets"
    else
      erb :"/users/login"
    end
  end

  post "/login" do
    @user = User.find_by_username(params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  # Log Out
  get "/logout" do
    if logged_in?
      session.clear()
      redirect "/login"
    else
      redirect "/login"
    end
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
