class UsersController < ApplicationController
  get '/signup' do

    if logged_in?
      redirect '/tweets'
    else
      erb :'users/signup'
    end
  end

  post '/signup' do

    if params[:username] == "" or params[:email] == "" or params[:password] == ""
      redirect 'users/signup'
    end

    user = User.create(params)
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
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

    user = User.find_by(:username => params[:username])

	  if user && user.authenticate(params[:password])
	    session[:user_id] = user.id
	    redirect '/tweets'
	  else
	    redirect '/users/login'
	  end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect 'users/login'
    else
      redirect '/index'
    end
  end



end
