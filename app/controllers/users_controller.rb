class UsersController < ApplicationController
  get '/signup' do
    if session[:user_id] == nil
      erb :'/users/create_user'
    else
      redirect to '/tweets'
    end
  end

  post '/signup' do
    @user = User.create(:username => params[:username],
      :email => params[:email], :password_digest => params[:password])
    session[:user_id] = @user.id
    if @user.username.present? && @user.password_digest.present? &&
      @user.email.present?
      redirect '/tweets'
    else
      redirect to '/signup'
    end
  end

  get '/login' do
    if session[:user_id] == nil
      erb :'/users/login'
    else
      redirect to '/tweets'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/tweets/show_tweet'
  end

  get '/logout' do
    if session[:user_id] == nil
      redirect "/"
    else
      session.clear
      redirect '/login'
    end
  end

end
