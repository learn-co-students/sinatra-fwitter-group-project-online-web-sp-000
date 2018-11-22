require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "supersecretpassword"
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
    erb :login
  end

  get '/tweets' do
    @tweets = Tweet.all
    erb :tweets
  end


  post '/login' do

    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      erb :error
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
