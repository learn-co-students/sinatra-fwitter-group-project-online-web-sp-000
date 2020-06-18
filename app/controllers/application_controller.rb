require './config/environment'

class ApplicationController < Sinatra::Base
  configure do
    enable :sessions
    set :session_secret, 'dsjljdlkjsdkljsd'
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if logged_in?
      redirect to '/tweets'
    end
    erb :'users/create_user'
  end

  post '/signup' do
    if params[:username] != "" && params[:email] != "" && params[:password] != ""
      @user = User.new(username: params[:username], email: params[:email], password: params[:password])
      @user.save
      session[:user_id] = @user.id
    redirect to '/tweets'
    else
    redirect to '/signup'
    end
  end

  get '/users/login' do
    if logged_in?
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
    erb :'users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if logged_in?
      # session[:user_id] = @user.id
      redirect to '/tweets'
    else
      redirect to '/users/login'
  end
end

  get '/logout' do
    if logged_in?
    session.clear
    redirect to '/users/login'
  else
  redirect to '/users/login'
  end
end

  post '/logout' do
    if logged_in?
      redirect to '/logout'
    else
      redirect to '/users/login'
  end
end

  helpers do
    def logged_in?
      !!current_user
    end
    def current_user
      User.find_by(id: session[:user_id])
    end
  end

end
