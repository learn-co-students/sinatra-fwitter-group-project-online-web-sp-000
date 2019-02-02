class UsersController < ApplicationController

  #load signup form
  get '/signup' do 
    if logged_in?
      redirect to '/tweets'
    else
      erb :'users/signup'
    end
  end

  #create new user
  post '/signup' do 
    if params["username"] == "" || params["email"] == "" || params["password"] == ""
      redirect '/signup'
    else
      @user = User.create(username: params["username"], email: params["email"], password_digest: params["password"])
      session[:user_id] = @user.id
      redirect '/tweets'
    end
  end

  #login form
  get '/login' do 
    if logged_in? 
      @user = current_user 
      redirect to '/tweets'
    else
      erb :'users/login'
    end
  end
  
  #login user
  post '/login' do 
    user = User.find_by(username: params["username"])
    if user.authenticate(params["password"])
      session[:user_id] = user.id
      redirect '/tweets'
    else 
      redirect to '/'
    end
  end

  #logout
  get '/logout' do 
    if logged_in?
      session.clear
    end
    redirect to '/login'
  end
  
  #show tweets
  get "/users/:slug" do 
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

end