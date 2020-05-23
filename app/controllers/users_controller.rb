class UsersController < ApplicationController
  get '/signup' do 
    if logged_in?
        redirect '/tweets'
    else 
        erb :'users/signup', locals: {message: "Please Sign Up before you Login"}
    end
  end

  post '/signup' do 
    if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
        user = User.create(params)
        session[:user_id] = user.id
	    redirect '/tweets'
	else
		redirect '/signup'
	end
  end

  get '/login' do 
    if !logged_in?
        erb :'/users/login'
    else 
        redirect '/tweets'
    end
  end

  post '/login' do 
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect '/tweets'
    else 
        redirect '/signup'
    end 
  end

  get '/logout' do
    if logged_in?
        session.destroy
        redirect '/login'
    else 
        redirect '/'
    end
  end

end
