require './config/environment'
require 'sinatra/base'
require 'rack-flash'


class ApplicationController < Sinatra::Base

  enable :sessions
  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    erb :index
  end

  get '/signup' do
    if Helpers.is_logged_in?(session)
      redirect to '/tweets'
    end

    erb :"signup"
  end

  post '/signup' do
    params.each do |label, user_input|
      if user_input.empty?
        flash[:signup_error] = "Please enter a value for #{label}"
        redirect to '/signup'
      end
    end

    user = User.create(:username => params["username"], :email => params["email"], :password => params["password"])
    session[:user_id] = user.id

    redirect to '/tweets'
  end

  get '/login' do
    if Helpers.is_logged_in?(session)
      redirect to '/tweets'
    end

    erb :"login"
  end

  post '/login' do
    user = User.find_by(:username => params["username"])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/tweets'
    else
      flash[:login_error] = "Incorrect login. Please try again."
      redirect to '/login'
    end
  end

  get '/tweets' do
    if !Helpers.is_logged_in?(session)
      redirect to '/login'
    end
    @tweets = Tweet.all
    @user = Helpers.current_user(session)
    erb :"/tweets/index"
  end

  get '/tweets/new' do
    if !Helpers.is_logged_in?(session)
      redirect to '/login'
    end
    erb :"/tweets/new"
  end

  post '/tweets' do
    user = Helpers.current_user(session)
    if params["content"].empty?
      flash[:empty_tweet] = "Please enter content for your tweet"
      redirect to '/tweets/new'
    end
    tweet = Tweet.create(:content => params["content"], :user_id => user.id)

    redirect to '/tweets'
  end

  get '/tweets/:id' do
    if !Helpers.is_logged_in?(session)
      redirect to '/login'
    end
    @tweet = Tweet.find(params[:id])
    erb :"tweets/show"
  end

  get '/tweets/:id/edit' do
    if !Helpers.is_logged_in?(session)
      redirect to '/login'
    end
    @tweet = Tweet.find(params[:id])
    if Helpers.current_user(session).id != @tweet.user_id
      flash[:wrong_user_edit] = "Sorry you can only edit your own tweets"
      redirect to '/tweets'
    end
    erb :"tweets/edit"
  end

  patch '/tweets/:id' do
    tweet = Tweet.find(params[:id])
    if params["content"].empty?
      flash[:empty_tweet] = "Please enter content for your tweet"
      redirect to "/tweets/#{params[:id]}/edit"
    end
    tweet.update(:content => params["content"])
    tweet.save

    redirect to "/tweets/#{tweet.id}"
  end

  delete '/tweets/:id' do
    if !Helpers.is_logged_in?(session)
      redirect to '/login'
    end
    @tweet = Tweet.find(params[:id])
    if Helpers.current_user(session).id != @tweet.user_id
      flash[:wrong_user] = "Sorry you can only delete your own tweets"
      redirect to '/tweets'
    end
    @tweet.destroy
    redirect to '/tweets'
  end

  get '/users/:slug' do
    slug = params[:slug]
    @user = User.find_by_slug(slug)
    erb :"users/show"
  end

  get '/logout' do
    if Helpers.is_logged_in?(session)
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end

end
