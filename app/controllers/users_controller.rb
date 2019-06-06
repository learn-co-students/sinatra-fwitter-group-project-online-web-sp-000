class UsersController < ApplicationController

  get '/signup' do
    if logged_in?(session)
      redirect '/tweets'
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    if !params[:email].empty? && !params[:username].empty? && !params[:password].empty?
      u = User.create(params)
      session[:user_id] = u.id
      redirect "/tweets"
    else
      redirect '/signup'
    end
  end

  get '/login' do
    if logged_in?(session)
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    u = User.find_by(username: params[:username])

    if u && u.authenticate(params[:password])
      session[:user_id] = u.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    if logged_in?(session)
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  get '/users/:slug' do
      @user = User.find_by_slug(params[:slug])
      erb :'/users/show'
  end

end
