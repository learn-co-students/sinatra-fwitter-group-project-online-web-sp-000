require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    erb :'/index'
  end

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'signup'
    end
  end
  
  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect '/signup'
    else
      user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    end
  end

  get '/tweets' do
    if !logged_in?
      redirect '/login'
    else
      @user = User.find(session[:user_id])
      erb :'tweets/index'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/index'
  end

  get '/tweets/new' do
    redirect '/login' if !logged_in?
    @user = User.find(session[:user_id])
    erb :'/tweets/new'
  end

  post '/tweets' do
    redirect '/tweets/new' if params[:content].empty?
    @tweet = Tweet.create(:content => params[:content], :user_id => session[:user_id])
    redirect '/tweets'
  end

  get '/tweets/:id' do
    redirect '/login' if !logged_in?
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/show'
  end

  get '/tweets/:id/edit' do
    redirect "/login" if !logged_in?
    @tweet = Tweet.find(params[:id])
    erb :'tweets/edit'
  end 
  
  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    redirect "/tweets/#{@tweet.id}/edit" if params[:content].empty?
    @tweet.content = params[:content] 
    @tweet.save
    redirect "/tweets"
  end
  
  delete '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    redirect "/tweets/#{params[:id]}" if current_user != @tweet.user
    @tweet.delete
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
