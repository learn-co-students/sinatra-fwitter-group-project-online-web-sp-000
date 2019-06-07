class UsersController < ApplicationController

  get '/signup' do
    if logged_in?(session)
      redirect to '/tweets'
    else
    end

    erb :'/users/create'
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      flash[:user_error] = "You must fill in all fields to continue"
      redirect "/signup"
    end

    @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
    session[:user_id] = @user.id
    redirect "/tweets"
  end

  get '/login' do
    if logged_in?(session)
      redirect '/tweets'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    @user = User.all.find_by(:username => params[:username])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/tweets"
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
    # binding.pry
  erb :'users/show'
  end

end
