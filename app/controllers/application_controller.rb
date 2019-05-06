require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if logged_in?
      redirect '/tweets'
      redirect to '/tweets'
    else
      erb :signup
    end
  end

  post '/signup' do
    #binding.pry
    if valid_signup?
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    if logged_in?
      redirect "/tweets"
    else
      erb :login
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect "/failure"
    end
  end

  get '/tweets' do
    #binding.pry
    if logged_in?
      @user = User.find(session[:user_id])
      erb :tweets
    else
      redirect "/login"
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect "/login"
    else
      redirect "/"
    end
  end

  get '/tweets/new' do
  end

  post '/tweets' do
    @tweet = Tweet.create(params)
    erb :'tweets/show'
  end

  get '/tweets/:id' do
    erb :'tweets/show'
  end


  helpers do
    def valid_signup?
      if params[:username] != "" &&  params[:email] != "" && params[:password] != "" && params[:username] && params[:email] && params[:password]
        true
      else
        false
      end
    end

    def logged_in?
      !!session[:user_id]
    end
  end

end
