require './config/environment'
require 'sinatra/base'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  enable :sessions
  use Rack::Flash

  configure do
    set :session_secret, "secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  
  end

  get '/signup' do
    if Helpers.is_logged_in?(session)
    redirect to '/tweets'
    end
    erb :"/users/create_user"

  end

  post '/signup' do
    params.each do |label, input|
      if input.empty?
        flash[:new_user_error] = "Input required. Please don't leave #{label} blank."
        redirect '/signup'
      end
    end

    user = User.create(:username => params["username"], :email => params["email"], :password => params["password"])
    session[:user_id] = user.id
    redirect to '/tweets'
  end

  get '/login' do
    if Helpers.is_logged_in?(session)
      redirect '/tweets'
    end
    erb :"/users/login"
  end

  post '/login' do
    user = User.find_by(:username => params["username"])
    
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      flash[:login_error] = "Invalid login. Please try again."
      redirect '/login'
    end
  end

  get '/tweets' do
    if !Helpers.is_logged_in?(session)
      redirect '/login'
    end

    @tweets = Tweet.all
    @user = Helpers.current_user(session)
    erb :"/tweets/tweets"

  end

  get '/tweets/new' do
    if !Helpers.is_logged_in?(session)
      redirect '/login'
    end
    erb :"tweets/new"
  end

  post '/tweets' do 
    user = Helpers.current_user(session)
    if params["content"].empty?
      flash[:empty_tweet] = "Please enter a new tweet"
      redirect '/tweets/new'
    end

    tweet = Tweet.create(:content => params["content"], :user_id => user.id)
    redirect '/tweets'
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
      redirect '/login'
    end
    @tweet = Tweet.find(params[:id])
    if Helpers.current_user(session).id != @tweet.user_id
      flash[:wrong_user_edit] = "You can only edit your own tweets"
      redirect '/tweets'
    end  
    erb :"tweets/edit"
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if params["content"].empty?
      flash[:empty_tweet] = "Please enter a tweet"
      redirect "/tweets/#{params[:id]}/edit"
    end
    if Helpers.current_user(session).id != @tweet.user_id
      flash[:wrong_user_edit] = "You can only edit your own tweets"
      redirect '/tweets'
    end  

    @tweet.update(:content => params["content"])
    @tweet.save
    redirect "/tweets/#{@tweet.id}"
  end

  post '/tweets/:id/delete' do
    if !Helpers.is_logged_in?(session)
      redirect '/login'
    end
    @tweet = Tweet.find(params[:id])
    if Helpers.current_user(session).id != @tweet.user_id
      flash[:wrong_user] = "You can only delete your own tweets"
      redirect '/tweets'
    end
    @tweet.delete
    redirect '/tweets'
  end

  get '/users/:slug' do
    slug = params[:slug]
    @user = User.find_by_slug(slug)
    erb :"users/show"
  end

  get '/logout' do
    if Helpers.is_logged_in?(session)
      session.clear
      redirect '/login'
    else
      redirect '/'
  end
end



end
