require './config/environment'

class UsersController < ApplicationController
  configure do
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'secret'
  end

  get '/signup' do
    if User.logged_in?(session)
      redirect to '/tweets'
    else
      erb :'/users/create_user'
    end
  end

  get '/login' do
    if User.logged_in?(session)
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

  get '/logout' do
    session.clear
    redirect to '/login'
  end

  post '/signup' do
    user = User.new(username: params[:username], email: params[:email], password: params[:password])

    if user.save
      session[:user_id] = user.id

      redirect to "/tweets"
    else
      redirect to '/signup'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username]) || User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/tweets"
    else
      @error_message = "Invalid user info.  Please provide a unique username, email, and password."
      erb :'/users/login'
    end
  end

end