require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'super secret'
  end

  get '/' do
    erb :index
  end

  get '/login' do
    if logged_in? 
      redirect :'/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    user=User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect :"/tweets"
    else
      redirect :'/' 
    end
  end

  get '/signup' do
    if logged_in?
      redirect :'/tweets'
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    user=User.create(params)
    if user.save
      session[:user_id]=user.id
      redirect :'/tweets'
    else
      redirect :'/signup'
    end
  end

  get '/tweets' do
    if logged_in?
    @tweets = Tweet.all
    @user=current_user
    erb :'/tweets/index'
    else
      redirect :'/login'
    end
  end

  get '/users/:user' do
    @user=User.find_by_slug(username: params[:user])
    erb :'/user/show'
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/new'
    else
      redirect :'/login'
    end
  end

  post '/tweets' do
    @tweet=Tweet.new(user_id: current_user.id, content: params[:content])

    if !logged_in?
      redirect :'/login'
    elsif @tweet.save && logged_in?
      redirect :"/tweets/#{@tweet.id}"
    else
      redirect :'tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
    @tweet=Tweet.find(params[:id])
    erb :'/tweets/show_tweet'
    else
      redirect :'/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet=Tweet.find(params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect
    end
  end

  patch '/edit/:id' do
    tweet=Tweet.find(params[:id])
    if !logged_in?
      redirect :'/login'
    elsif params[:content]==''
      redirect :"/tweets/#{tweet.id}/edit"
    else
      tweet.update(content: params[:content])
      redirect :"/tweets/#{tweet.id}"
    end
  end
  
  get '/logout' do
    if logged_in?
      logout
      redirect :'/login'
    else
      redirect :'/login'
    end
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def logout
      session.clear
    end

    def current_user
      User.find(session[:user_id])
    end

    def slug
      self.username.gsub(" ", "-")
    end
  
    def reverse_slug_name(name)
      name.gsub("-", " ")
    end
  end

end
