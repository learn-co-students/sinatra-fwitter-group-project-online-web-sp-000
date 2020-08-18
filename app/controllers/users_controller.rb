class UsersController < ApplicationController

  get '/signup' do
    if Helper.is_logged_in?(session)
      redirect "/tweets"
    end
    erb :"users/signup"
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect "/signup"
    end
    user = User.create(params)
    session[:user_id] = user.id
    redirect "/tweets"
  end

  get '/login' do
    if Helper.is_logged_in?(session)
      redirect "/tweets"
    end
    erb :"users/login"
  end

  post '/login' do
    if params[:username] != "" && params[:password] != ""
      user = User.find_by(username: params[:username])
      if !!user && user.validate(params[:password])
        session[:user_id] = user.id
        redirect '/tweets'
      else
        redirect '/login'
      end
    else
      redirect '/login'
    end
  end

  get '/logout' do
    session[:user_id] = ""
    redirect "/login"
  end

  get "/users/:user_slug" do
    @user = User.find_by_slug(params[:user_slug])
    if !@user
      redirect '/tweets'
    end
    erb :"users/show"
  end
end
