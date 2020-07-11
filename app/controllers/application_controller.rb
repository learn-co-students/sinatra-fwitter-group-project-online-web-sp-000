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
  end

  get '/signup' do
    if session[:id]
      redirect '/tweets'
    else
      erb :signup
    end
  end

  post '/signup' do
    @session = session
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to "/signup"
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      @session[:id] = @user.id
      redirect to '/tweets'
    end
  end

  get '/login' do
    if session[:id]
      redirect to "/tweets"
    else
      erb :login
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    session[:id] = @user.id
    if @user && @user.authenticate(params[:password])
      redirect to "/tweets"
    else
      redirect to "/login"
    end
  end

  get '/logout' do
    if session[:id] != nil
      @user = User.find(session[:id])
      session.clear
      redirect to '/login'
    else
      redirect to '/login'
    end
  end

  post '/logout' do
    session.clear
    redirect to "/login"
  end

end
