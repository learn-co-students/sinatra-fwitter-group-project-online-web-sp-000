require "./config/environment"

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, "public"
    set :views, "app/views"
    enable :sessions
    set :session_secret, "password_security"
  end

  get "/" do
    erb :index
  end

  get "/signup" do
    if session[:user_id].nil?
      erb :signup
    else
      redirect "/tweets"
    end
  end

  post "/signup" do
    if params[:username].size > 0 && params[:email].size > 0 && params[:password].size > 0
      session[:user_id] = User.create(params).id
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

  get "/login" do
    if session[:user_id].nil?
      erb :login
    else
      redirect "/tweets"
    end
  end

  post "/login" do
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  get "/logout" do
    if session[:user_id]
      session.clear
      redirect "/login"
    else
      redirect "/"
    end
  end
end
