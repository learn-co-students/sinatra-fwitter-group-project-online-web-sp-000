require './config/environment'

class ApplicationController < Sinatra::Base
  # use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fancypantssecret"
  end

  get '/' do
    erb :'index'
  end

  get '/signup' do
    if logged_in
      redirect '/tweets'
    else
      erb :'users/signup'
    end
  end

  post '/signup' do
    @new_user = User.new(username: params[:username], password: params[:password], email: params[:email])
  
    if @new_user.save
        flash[:success] =  "You have successfully signed up and have been logged in!"
        session[:user_id] = @new_user.id
        redirect '/tweets'
    else
        flash[:error] = @new_user.errors.full_messages.join("<br>")
        redirect '/signup'
    end
  end

  get '/tweets/new' do
    if logged_in
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  get '/tweets' do
    if logged_in
      @tweets = Tweet.all
      erb :'tweets/index'
    else
      redirect '/login'
    end
  end

  #Need to work on my routes for Getting a new tweet form and Posting that new tweet.  Did these two in a rush and most likely are messed up.
  post '/tweets' do
    if logged_in
      get_session_user
      @tweet = Tweet.new(content: params[:content])
      @tweet.user_id = @user.id

      if @tweet.save
        redirect '/tweets'
      else
        redirect '/tweets/new'
      end
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in
      get_session_user
      get_tweet_by_id

      erb :'tweets/show'
      
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    user_verified_action do
      erb :'tweets/edit'
    end
  end

  delete '/tweets/:id' do
    user_verified_action do
      @tweet.destroy
      redirect '/tweets'
    end
  end

  patch '/tweets/:id' do
    user_verified_action do
      if @tweet.update(content: params[:content])
        redirect '/tweets'
      else
        redirect "/tweets/#{@tweet.id}/edit"
      end
    end
  end

  get "/users/:slug" do
    #if logged_in
      @user = User.find_by_slug(slug)
      @tweets = @user.tweets

      erb :'users/show'
  end


  get '/login' do
    if logged_in
      redirect '/tweets'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user
       @password = @user.authenticate(params[:password])
    end
    
    if @user && @password
       flash[:success] = "Successfully logged in!"
       session[:user_id] = @user.id
       redirect '/tweets'
    else  
       flash[:error] = "Incorrect Username or Password <br> Please try again."
       redirect '/login'
    end
  end

  get '/logout' do
    if logged_in
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  get '/users/:id' do
    if logged_in
      get_session_user
      @tweets = @user.tweets
      erb :'tweets/index'
    else
      redirect '/login'
    end
  end

  helpers
  def get_session_user
    @user = User.find_by_id(session[:user_id])
  end
  
  def logged_in
     session.has_key?(:user_id)
  end

  def get_tweet_by_id(id=params[:id])
    @tweet = Tweet.find_by_id(id)
  end

  #This does my user verification checking (is the user logged in? && is the user doing something to their own data? if not, forward them to the login page) and then actions a block provided to it.
  def user_verified_action(tweet_id: params[:id])
    get_session_user
    get_tweet_by_id(tweet_id)

    if @user
      if @user.id == @tweet.user_id
         yield if block_given?
      else
         flash[:error] = "You do not have access to perform this action to this resource."
         redirect '/tweets'
      end
    else
      flash[:error] = "You must be logged in to view perform this action.<br>Please login."
      redirect '/login'
    end
  end
end

class Helpers
  def self.is_logged_in?(user_session)
    user_session.has_key?(:user_id)
  end
end