class UsersController < ApplicationController
  get '/signup' do
    if !Helpers.is_logged_in?(session)
      erb :'/users/signup'
    else
      redirect to '/tweets'
    end
  end

  post '/signup' do
    #binding.pry
    if params.values.any?("")
      redirect to '/signup'
    else
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect to '/tweets'
    end
  end

  get '/login' do
    if !Helpers.is_logged_in?(session)
      erb :'/users/login'
    else
      redirect to '/tweets'
    end
  end

  post '/login' do
    #binding.pry
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password]) && !Helpers.is_logged_in?(session)
      session[:user_id] = @user.id
    else
      redirect to '/login'
    end
    redirect to '/tweets'
  end

  get '/logout' do
    if !Helpers.is_logged_in?(session)
      redirect to '/tweets'
    else
      erb :'/users/logout'
    end
  end

  post '/logout' do
    session.clear
    redirect to '/login'
  end

  get '/users/:id' do
    @user = User.find_by_id(params[:id])
    erb :'/users/show'
  end
end
