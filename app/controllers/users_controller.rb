class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect to "/tweets"
    else
      erb :"users/create_user"
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      redirect "/signup"
    else
      @user = User.create(username: params[:username], email: params[:email], password: [:password])
      session[:user_id] = @user.id
      redirect "/tweets"
    end
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :"users/login"
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end

  helpers do
      def logged_in?
        !!session[:user_id]
      end

      def current_user
        User.find(session[:user_id])
      end
    end

end
