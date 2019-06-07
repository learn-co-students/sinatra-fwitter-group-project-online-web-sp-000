class UsersController < ApplicationController

  #action to display signup page
  get '/signup' do
    if is_logged_in?(session)
      redirect '/tweets'
    else
    erb :'/users/create_users'
    end
  end

  #action to signup user to a new account
  post '/signup' do
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
      if params[:username] == "" || params[:email] == "" || params[:password] == ""
        redirect '/signup'
      else
        @user.save
        session[:user_id] = @user.id
        redirect '/tweets'
    end
  end

  #action to display login page
  get '/login' do
    if is_logged_in?(session)
      redirect '/tweets'
    else
    erb :'users/login'
    end
  end

  #action to log into account
  post '/login' do
    # binding.pry
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    end
    redirect '/login'
  end

  #action to logout
  get '/logout' do
    if is_logged_in?(session)
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  #action to display individual user show page
  # get '/users/:id' do
  #   @user = User.find(session[:user_id])
  #   erb :'/users/show'
  # end

  #action to display individual user show page by slugging username
  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

end
