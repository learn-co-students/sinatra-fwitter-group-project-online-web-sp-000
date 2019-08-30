class UsersController < ApplicationController

  get '/signup' do
    erb :"users/create_user"
  end

  post '/signup' do
    params.each do |label, input|
      if input.empty?
        flash[:new_user_error] = "Please fill in #{label}."
        redirect '/signup'
      end
    end
     user = User.create(username: params["username"], email: params["email"], password: params["password"])
     session[:user_id] = user.id
     redirect "/tweets"

     if Helpers.is_logged_in?

     end
  end

  get '/login' do
    if Helpers.is_logged_in?(session)
      redirect to '/tweets'
    end
    erb :"users/login"
  end

  post '/login' do
    user = User.find_by(:username => params["username"])
     if user && user.authenticate(params[:password])
       session[:user_id] = user.id
       redirect to '/tweets'
     else
       flash[:login_error] = "Incorrect username and/or password. Please try again"
       redirect to 'login'
     end
  end




end
