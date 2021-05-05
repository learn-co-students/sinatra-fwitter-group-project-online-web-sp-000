class UsersController < ApplicationController
  get '/signup' do
    if !logged_in?
      erb :"users/create_user"
    else
      redirect '/tweets'
    end
  end

  post '/signup' do
    @user = User.create(username: params[:username], email: params[:email], password: params[:password])
    if @user.save
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

  get '/login' do
    if !logged_in?
      erb :"users/login"
    else
      redirect '/tweets'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  get '/logout' do
    session.clear
    redirect "/login"
  end

  post '/logout' do
    session.clear
    redirect "/login"
  end

  get '/users/:slug' do
    #if defined?(current_user) && logged_in?
      if User.find_by_slug(params[:slug])
        @user = User.find_by_slug(params[:slug])
        erb :"users/show"
      else
        redirect "users/#{current_user.slug}"
      end
    #else
    #  redirect "/login"
    #end
  end

end
