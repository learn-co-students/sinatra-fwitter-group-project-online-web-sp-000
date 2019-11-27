require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :session_secret, "secret" # sets encryption key for session
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  enable :sessions # need this to log in
  enable :method_override

  get '/' do
    erb :index
  end

  get '/signup' do
    if Helpers.logged_in?(session)
      Helpers.current_user(session)
      redirect to '/tweets'
    else
    #   redirect to '/signup'
      erb :'/users/signup'
    end
  end

  post '/signup' do
    # create user
    if params["username"] == "" || params["password"] == "" || params["email"] == ""
      redirect '/signup'  # redirects to signup page
    else
      @user = User.create(username: params["username"], password: params["password"], email: params["email"])
      @user.save
      session[:user_id] = @user.id
      redirect "/tweets"
    end
  end

  get '/login' do
    # loads all tweets after login (redirect)
    # do not let users view login page if already logged in
    if Helpers.logged_in?(session)
      Helpers.current_user(session)
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "/tweets"
    else
      redirect to "/login"
    end
    redirect to "/login"
  end

  get '/logout' do
    if Helpers.logged_in?(session)
      session.clear
      redirect to "/login"
    else
      redirect '/'
    end
  end
end
