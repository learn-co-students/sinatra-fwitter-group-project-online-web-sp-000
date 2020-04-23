require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions 
    set :session_secret, "secretive squirrel"
  end

  get "/" do 
    erb :index
  end 

  get "/signup" do 
    if logged_in? 
      redirect :"tweets/index"
    end
    erb :"signup"
  end 

  post "/signup" do 
    if params[:username].empty? || params[:email].empty? || params[:password].empty? 
      redirect :"/signup"
    else 
      @user = User.create(params)
      session[:user_id] = @user[:id]
      redirect :"tweets/index"
    end
  end

  get "/login" do 
    if logged_in? 
      redirect :"/tweets"
    end
    erb :"login"
  end 

  post "/login" do 
    @user = User.find_by(username: params[:username])
    session[:user_id] = @user.id
    redirect to "/tweets"
  end 

  get '/logout' do 
    if logged_in?
      redirect :"/login"
    end
    redirect :"/"
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
