class UsersController < ApplicationController
  get "/signup" do
    if session[:id]
      redirect "/tweets"
    else
      erb :signup
    end
  end

  post "/signup" do
	  if params[:username]? && params[:email]? && params[:password]?
      user = User.new(username: params[:username], email: params[:email], password: params[:password])
      session[:id] = user.id
	    redirect "/tweets"
    else
      redirect "/signup"
      # Include flash message stating what went wrong
	  end
  end

  get '/account' do
    @user = User.find(session[:user_id])
    erb :account
  end

  get "/login" do
    erb :login
  end

  post "/login" do
    user = User.find_by(:username => params[:username])

	  if user && user.authenticate(params[:password])
	    session[:user_id] = user.id
	    redirect "/account"
	  else
	    redirect "/failure"
	  end
  end

  get "/failure" do
    erb :failure
  end

  get "/logout" do
    session.clear
    redirect "/"
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
