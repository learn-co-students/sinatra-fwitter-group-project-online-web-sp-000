class UsersController < ApplicationController

  # SIGN UP
  get '/signup' do
    if logged_in?
      redirect to :'/tweets'
    end
    erb :'/users/create_user'
  end

  post '/signup' do
    @user = User.new(params)
    if @user.save
      session[:id] = @user.id
      redirect to :'/tweets'
    else
      redirect to :'/signup'
    end
  end

  # LOG IN
  get '/login' do
    if logged_in?
      redirect to :'/tweets'
    end
    erb :'/users/login'
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    session[:id] = @user.id
    redirect to :'/tweets'
  end


  # USER SHOW PAGE
  get '/users/:slug' do
    if @user = User.find_by_slug(params[:slug])
      erb :'/users/show'
    else
      redirect to '/tweets'
    end
  end

  # LOG OUT
  get '/logout' do
    if logged_in?
      session.clear
    end
    redirect to '/login'
  end

end
