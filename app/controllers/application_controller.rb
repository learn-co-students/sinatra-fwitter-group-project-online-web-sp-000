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
    redirect '/tweets' if logged_in?
    erb :signup
  end

  post '/signup' do
    user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if user.save && params[:username] != '' && params[:email] != ''
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end

  end

  get '/tweets' do
    redirect '/login' if !logged_in?
    @tweets = Tweet.all
    erb :'tweets/index'
  end

  get '/login' do
    redirect '/tweets' if logged_in?
    erb :'users/login'
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
    @user = current_user
    if @user 
      erb :'users/show' 
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    redirect '/login' if !logged_in?
    erb :'tweets/new'
  end

  post '/tweets' do
    redirect '/tweets/new' if params[:content] == ''
    user = current_user
    user.tweets << Tweet.create(content: params[:content])
    user.save
    redirect "/users/#{user.slug}"
  end

  get '/tweets/:id' do
    redirect '/login' if !logged_in?
    @tweet = Tweet.find(params[:id])
    erb :'tweets/show'
  end

  delete '/tweets/:id' do
    tweet = Tweet.find(params[:id])
    redirect '/tweets' if !current_user.tweets.include?(tweet)
    tweet.delete
    redirect "/users/#{current_user.slug}"
  end

  get '/tweets/:id/edit' do
    redirect '/login' if !logged_in?
    @tweet = Tweet.find(params[:id])
    redirect '/tweets' if !current_user.tweets.include?(@tweet)
    erb :'tweets/edit'
  end

  patch '/tweets/:id' do
    tweet = Tweet.find(params[:id])
    redirect "/tweets/#{tweet.id}/edit" if params[:content] == ''
    tweet.update(content: params[:content])
    redirect "/tweets/#{tweet.id}"
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
