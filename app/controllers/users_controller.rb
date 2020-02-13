class UsersController < ApplicationController

  get '/signup' do
    if Helpers.is_logged_in?(session)
      redirect to '/tweets'
    end
    erb :'/users/new'
  end

  post '/signup' do
    @user = User.create(params)
    if @user.valid?
      @user.save
      session["user_id"] = @user.id
      redirect to '/tweets'
    else
      flash[:message] = "Missing Signup Field, Please Try Again"
      redirect to '/signup'
    end
  end

  get '/login' do
    if Helpers.is_logged_in?(session)
      redirect to '/tweets'
    end
    erb :'/users/login'
  end

  post '/login' do
    @user = User.find_by(username: params["username"])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      flash[:login_error] = "Login Info Incorrect.  Please try again."
      erb :'/users/login'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

  get '/logout' do
    if Helpers.is_logged_in?(session)
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end

end