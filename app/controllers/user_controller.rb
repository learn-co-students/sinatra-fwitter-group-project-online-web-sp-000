class UserController < ApplicationController

  get '/signup' do
    if Helpers.is_logged_in?(session)
      redirect to '/tweets'
    end
    erb :'/users/create_user'
  end

  post '/signup' do
    if !(params.has_value?(""))
      user = User.create(params)
      session["user_id"] = user.id
      redirect to '/tweets'
    else
      redirect to '/signup'
    end
  end

  get '/login' do
    if Helpers.is_logged_in?(session)
      redirect to '/tweets'
    end
    erb :'/users/login'
  end

  post '/login' do
  user = User.find_by(:username => params[:username])
  	if user && user.authenticate(params[:password])
      session["user_id"] = user.id
      redirect to "/tweets"
    else
      redirect to "/login"
    end
	end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    if !@user.nil?
      erb :'/users/user_tweets'
    else
      redirect to '/login'
    end
  end

  get '/logout' do
    if Helpers.is_logged_in?(session)
      session.clear
    else
      redirect to '/'
    end
    redirect to '/login'
  end
end
