class UsersController < ApplicationController

  #load signup form
  get '/signup' do 
    if session[:user_id]
      redirect to '/tweets'
    else
      erb :'user/signup'
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
    if session[:user_id]
      @user = User.find(session[:user_id])
      redirect to '/tweets'
    else
      erb :'user/login'
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
    if session[:user_id]
      session.clear
    end
    redirect to '/login'
  end
  
  #show tweets
  get "/users/:slug" do 
    @user = User.find_by_slug(params[:slug])
    erb :'user/show'
  end

  #tweets landing page
  get '/tweets' do 
    if session[:user_id]
      @user = User.find(session[:user_id])
      erb :'user/show'
    else 
      redirect to '/login'
    end
  end

end