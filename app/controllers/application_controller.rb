require './config/environment'


class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    enable :sessions
    set :session_secret, "fwitter_secret"
    set :views, 'app/views'
  end

  get '/' do
  	erb :index
  end

  get '/signup' do
    if session[:user_id]
      redirect "/tweets"
    else
      erb :"users/create_user"
    end
  end

  get '/login' do
    if session[:user_id]
      redirect "/tweets"
    else
  	 erb :"users/login"
    end
  end

  get '/tweets' do
      if session[:user_id]
        @user = User.find(session[:user_id])
        @tweets = Tweet.all
        erb :"/tweets/tweets"
      else
        redirect '/login'
      end
  end


  post '/signup' do
  	if !params.values.any? ("")
      @user = User.new(username: params[:username], email: params[:email], password: params[:password])
  		@user.save
  		session[:user_id] = @user.id
  		redirect '/tweets'
  	else
  		redirect '/signup'
  	end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect "/login"
    end
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :"/users/show"
  end




end
