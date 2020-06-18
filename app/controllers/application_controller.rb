require './config/environment'
class ApplicationController < Sinatra::Base
  configure do
    enable :sessions
    set :session_secret, 'dsjljdlkjsdkljsd'
    set :public_folder, 'public'
    set :views, 'app/views'
  end
<<<<<<< HEAD
  get '/' do
    erb :index
  end
=======

  get '/' do
    erb :index
  end

>>>>>>> 6265492469202805c30fcd2243607474289ef005
  get '/signup' do
    if logged_in?
      redirect to '/tweets'
    end
    erb :'users/create_user'
  end
<<<<<<< HEAD
=======

>>>>>>> 6265492469202805c30fcd2243607474289ef005
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
<<<<<<< HEAD
=======

>>>>>>> 6265492469202805c30fcd2243607474289ef005
  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect to '/tweets'
    end
  end
<<<<<<< HEAD
=======

>>>>>>> 6265492469202805c30fcd2243607474289ef005
  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/tweets"
    else
      redirect to '/signup'
    end
  end
<<<<<<< HEAD
  get '/logout' do
    if logged_in?
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
=======

  get '/logout' do
    if logged_in?
    session.destroy
    redirect to '/login'
    else
    redirect to '/'
>>>>>>> 6265492469202805c30fcd2243607474289ef005
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
