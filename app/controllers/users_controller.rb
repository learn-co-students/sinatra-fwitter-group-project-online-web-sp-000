class UsersController < ApplicationController
  get "/signup" do
    if session[:user_id]
      redirect "/tweets"
    else
      erb :'users/signup'
    end
  end

  post "/signup" do
    user = User.create(username: params[:username], email: params[:email], password: params[:password])
	  if user.username? && user.email? && user.password_digest?
      session[:user_id] = user.id
	    redirect "/tweets"
    else
      redirect "/signup"
      # Include flash message stating what went wrong
	  end
  end

  get "/login" do
    if logged_in?
      redirect "/tweets"
    else
      erb :'users/login'
    end
  end

  post "/login" do
    user = User.find_by(username: params[:username])
    if !user
      user = User.find_by(email: params[:email])
    end
	  if user && user.authenticate(params[:password])
	    session[:user_id] = user.id
	    redirect "/tweets"
	  else
	    redirect "/login"
      # Include flash message stating what went wrong
	  end
  end

  get "/logout" do
    session.clear
    redirect "/login"
  end

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end
end
