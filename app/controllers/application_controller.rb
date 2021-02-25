require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'secret'
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

    def logout
      session.clear
    end

  end

  get '/' do
    erb :home
  end

  get '/signup' do
    redirect '/tweets' if logged_in?

    erb :signup
  end

  post '/signup' do
    username = params[:username]
    email = params[:email]
    password = params[:password]

    redirect '/signup' if username.empty? || email.empty? || password.empty?

    @user = User.create(username: username, email: email, password: password)
    @user.save
    session[:user_id] = @user.id
    redirect '/tweets'
  end
end
