require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  enable :sessions

  get '/' do
    "Welcome to Fwitter"
  end

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    end
    erb :'/users/create_user'
  end

  post '/signup' do
    user = User.create(params)
    if user.valid_signup
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/tweets' do #to see all of everyone's tweets
    if logged_in?
      @tweets = Tweet.all
      erb :'/tweets/index'
    else
      redirect '/login'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'/users/login'
    else
      redirect '/tweets'
    end      
  end

  post '/login' do
    user = User.find_by(username: params[:username]).authenticate(params[:password])
    if !!user
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    #binding.pry
    if logged_in?
      #binding.pry
      session[:user_id] = nil
      redirect '/login'
    else
      redirect '/'
    end
  end

  get "/users/:user" do #to see all of a single user's tweets
    @tweets = User.find_by(username: params[:user]).tweets
    erb :'/users/tweets'
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
