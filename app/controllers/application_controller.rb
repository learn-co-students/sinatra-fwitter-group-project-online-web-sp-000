require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter"
  end

  def current_user
    User.find_by(id: session[:user])
  end

  def logged_in?
    if session[:user].class == Integer
      true
    else
      false
    end
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    @user = current_user
    if logged_in? == true
      redirect '/tweets'
    else
      erb :signup
    end
  end

  post '/signup' do
    if params[:email] == "" || params[:username] == "" || params[:password] ==""
      redirect '/signup'
    else
      @user = User.create(params)
      session[:user] = @user.id
      redirect "/tweets"
    end
  end

  get '/login' do
    @user = current_user
    if logged_in? == true
      redirect '/tweets'
    else
      erb :login
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user] = @user.id
      redirect "/tweets"
    else
      redirect '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end

end
