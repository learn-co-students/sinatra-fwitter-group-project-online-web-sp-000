class UsersController < ApplicationController
  get '/signup' do

    erb :'/users/create_user'
    binding.pry
  end
    
  post '/signup' do
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if @user.save
      session[:user_id] = @user.id

      redirect '/tweets'
    elsif params[:username].empty? || params[:email].empty? || params[:password].empty?

      redirect '/signup'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username], password: params[:password])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id

     redirect '/tweets'
    else
    redirect '/signup' #error page?
    end
  end

  get '/logout' do
    session.clear

    redirect '/index'
  end

  get '/users/:slug' do
  @user = User.find_by_slug(params[:slug])

  erb :'/show'
  end

end
