class UsersController < ApplicationController

  get '/signup' do
      if !logged_in?
        erb :'/users/signup', locals: {message: "Please sign up before you sign in"}
      else
        redirect to '/tweets'
      end
  end

  post '/signup' do
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      redirect to '/signup'
    else
      @user = User.create( username: params[:username], email: params[:email], password: params[:password] )
      session[:user_id] = @user.id
      redirect to '/tweets'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect to '/tweets'
    end
  end

end
