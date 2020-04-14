class UsersController < ApplicationController

  get '/login' do
    erb :'/users/login'
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
    session.clear
    redirect "/"
  end

end
