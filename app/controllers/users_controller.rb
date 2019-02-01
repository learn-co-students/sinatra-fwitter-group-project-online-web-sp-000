class UsersController < ApplicationController

  #load signup form
  get '/signup' do 
    if session[:user_id]
      redirect to '/tweets'
    else
      erb :'user/signup'
    end
  end

  post '/signup' do 
    if params["username"] == "" || params["email"] == "" || params["password"] == ""
      redirect '/signup'
    else
      @user = User.create(username: params["username"], email: params["email"], password: params["password"])
      session[:user_id] = @user.id
      redirect '/tweets'
    end
  end
end