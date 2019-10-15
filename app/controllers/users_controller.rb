require "./config/environment"
require "./app/models/user"
class UsersController < ApplicationController
  configure do
    set :views, "app/views"
    enable :sessions
    set :session_secret, "password_security"
  end
  # get "/" do
  #   erb :index
  # end
  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    # binding.pry
    erb :'users/show'
  end
  get "/signup" do
    if is_logged_in?
      redirect to '/tweets'
    else
      erb :'users/create_user'
    end
  end
  post "/signup" do
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      redirect '/signup'
    else
      @user = User.new(params)
      @user.save
      session[:user_id] = @user.id
      redirect to '/tweets'
    end
  end

  get '/account' do
    @user = User.find(session[:user_id])
    erb :account
  end
  get "/login" do
    if is_logged_in?
      redirect to '/tweets'
    else
      erb :'users/login'
    end
  end
  post "/login" do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "/tweets"
    else
      redirect to "/signup"
    end
  end

  get "/failure" do
    erb :failure
  end
  get "/logout" do
    if is_logged_in?
      # redirect to '/tweets'
      session.destroy
      redirect to "/login"
    else
      redirect to '/'
    end
  end

end
