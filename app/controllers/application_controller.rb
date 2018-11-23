rrequire './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "supersecretpassword"
  end

  delete '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if Helpers.is_logged_in?(session) && @tweet.user_id == session[:user_id]
      @tweet.destroy
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if Helpers.is_logged_in?(session)
      redirect "/tweets"
    end
    erb :signup
  end

  get '/login' do
    if Helpers.is_logged_in?(session)
      redirect "/tweets"
    end
    erb :login
  end

  get '/logout' do
    session.clear
    redirect "/login"
  end

  get '/tweets' do
    if Helpers.is_logged_in?(session)
      @tweets = Tweet.all
      erb :tweets
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    if Helpers.is_logged_in?(session)
      erb :new_tweet
    else
      redirect "/login"
    end
  end

  get '/tweets/:id' do
    if Helpers.is_logged_in?(session)
      @tweet = Tweet.find_by_id(params[:id])
      erb :show_tweet
    else
      redirect "/login"
    end
  end

  get '/tweets/:id/edit' do
    if Helpers.is_logged_in?(session)
      @tweet = Tweet.find_by_id(params[:id])
      erb :edit_tweet
    else
      redirect "/login"
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :show
  end

  patch '/tweets/:id' do
    tweet = Tweet.find_by_id(params[:id])
    if !params[:content].empty?
      tweet.content = params[:content]
      tweet.save
      redirect "/tweets/#{tweet.id}"
    else
      redirect "/tweets/#{tweet.id}/edit"
    end
  end

  post '/tweets' do
    if !params[:content].empty?
      tweet = Tweet.create(content: params[:content])
      tweet.user_id = Helpers.current_user(session).id
      tweet.save
    end
    redirect "/tweets/new"
  end

  post '/login' do

    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/login"
    end

  end

  post '/signup' do
    if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
      user = User.create(username: params[:username])
      user.email = params[:email]
      user.password = params[:password]
      user.save
      session[:user_id] = user.id
      redirect '/tweets'
    end
    redirect '/signup'
  end

end
