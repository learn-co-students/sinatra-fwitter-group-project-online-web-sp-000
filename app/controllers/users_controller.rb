class UsersController < ApplicationController

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  get '/signup' do # Loads form to sign up
    if logged_in?
      redirect "/tweets"
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do # Receives submitted form
    if valid_new_user?
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

  get '/login' do # Loads form to log in
    if logged_in?
      redirect "/tweets"
    else
      erb :'users/login'
    end
  end

  post '/login' do # Receives submitted form to log in
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect "/login"
    end
  end

  get '/logout' do # Clear the session hash, and redirect the user to /login.
    if logged_in?
      session.destroy
      redirect "/login"
    else
      redirect "/"
    end
  end

end
