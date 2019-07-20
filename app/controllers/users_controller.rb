class UsersController < ApplicationController

  get '/login' do
    if !logged_in?
      erb :'/users/login'
    else
      erb :'/tweets'
    end
  end

  get '/signup' do
    if !logged_in?
      erb :'/users/signup'
    else
      erb :'/tweets'
    end
  end

  post '/signup' do
    @user = User.create(params[:user])
    session[:user_id] = @user.id

    redirect '/tweets'
  end

  get '/logout' do
    session.clear
    redirect "/login"
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
