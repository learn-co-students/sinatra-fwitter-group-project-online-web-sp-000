class UsersController < ApplicationController

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/users/:user_slug" do
    @user = User.find_by_slug(params[:user_slug])
    erb :'users/show'
  end

  get "/signup" do
    if session[:id]
      @user = User.find(session[:id])
      redirect to "/tweets"
    end
    erb :'users/create_user'
  end

  post "/signup" do
    @user = User.new(params)
    @user.save
    session[:id] = @user.id
    if session[:id]
      redirect to "/tweets"
    else
      redirect to "/signup"
    end
  end

  get "/login" do
    if session[:id]
      @user = User.find(session[:id])
      redirect to "/tweets"
    end
    erb :'users/login'
  end

  post "/login" do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect to "/tweets"
    else
      redirect to "/signup"
    end
  end

  get "/logout" do
    session.clear
    redirect to "/login"
  end

end
