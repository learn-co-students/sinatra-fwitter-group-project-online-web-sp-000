class UsersController < ApplicationController
  
  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :"users/signup"
    end
  end
  
  post '/signup' do
    if params.values.any? {|param| param.empty?}
      redirect '/signup'
    else
      User.create(params)
      session[:username] = params[:username]
      redirect '/tweets'
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
    @user = User.find_by(username:params[:username])
    if @user.authenticate(params[:password])
      session[:username] = params[:username] 
      redirect "/tweets"
    else
      redirect '/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])

    erb :"users/show"
  end
  
  helpers do
    def current_user
      User.find_by(username:session[:username])
    end
    
    def logged_in?
      !!session[:username]
    end
  end
end
