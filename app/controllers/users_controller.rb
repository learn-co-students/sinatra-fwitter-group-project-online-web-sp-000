class UsersController < ApplicationController

  #SignUp
  get '/signup' do
    if !logged_in?
      erb :'users/create_user'
    else
      redirect to '/tweets'
    end
  end

  post '/signup' do

    if params[:username] == "" || params[:email] == "" ||params[:password] == ""
      redirect to '/signup'
    else
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to '/tweets'
    end
  end

  #Login

  get "/login" do

    erb :'users/login'
  end

  post "/login" do

    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id

      redirect to '/tweets'
    else
      redirect to '/failure'
    end
  end

  get "/failure" do

    erb :'users/failure'
  end

  get "/logout" do
    session.clear
    redirect '/login'
  end

end
