class UsersController < ApplicationController
  get '/signup' do

    if Helpers.is_logged_in?(session)
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
    if Helpers.is_logged_in?(session)
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
    if Helpers.is_logged_in?(session)
      session.clear
      redirect 'users/login'
    else
      redirect '/index'
    end
  end

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end



end
