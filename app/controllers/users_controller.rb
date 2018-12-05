class UserController < ApplicationController

  # Index Action
  get '/users' do
    @users = User.all
    erb :'/users/index'
  end

  # Login Action
  get '/login' do
    if !session[:id]
      erb :'users/login'
    else
      redirect "/tweets"
    end    
  end

  post '/login' do
    if params['username'].empty? || params['password'].empty? 
      session[:flash] = "You must enter a username and password."
      redirect '/login' 
    end
    
    user = User.find_by(username: params[:username])    
    if user && user.authenticate(params[:password])
      session[:id] = user.id
      redirect '/tweets'
    else
      session[:flash] = "Login failed: " + (user ? "Incorrect password." : "User '#{params[:username]}' not found.")
      redirect '/login'
    end
  end
  
  # Logout action
  get '/logout' do
    if session[:id]
      session.clear
      # binding.pry
      redirect '/login'
    else
      redirect "/"
    end
  end

  # New Action
  get '/signup' do
    if !session[:id]
      erb :'users/create_user'
    else
      redirect "/tweets"
    end
  end  
  
  # Create Action
  post '/signup' do
    if params['username'].empty? || params['password'].empty? || params['email'].empty?
      session[:flash] = "You must enter a username, email and password."
      redirect '/signup' 
    end
    
    user = User.create(username:params['username'], password:params['password'], email:[params['email']])
    session[:id] = user.id
    redirect "/tweets"
  end
  
  # Show Action
  get '/users/:id' do
    @user = User.find(params[:id])
    erb :'/users/show'
  end
  
  # Edit Action
  get '/users/:id/edit' do
    @user = User.find(params[:id])
    @tweets = Tweet.all
    erb :'/users/edit'
  end
  
  # Patch Action
  patch '/users/:id' do
    params[:song_info]['tweet_ids'].clear if !params[:user].keys.include?('tweet_ids')
    user = User.find(params[:id])
    user.update(params['user'])

    user.tweets << Tweet.create(name: params['tweet_name']) unless params['tweet_name'].empty?
    user.save
    redirect "users/#{user.id}"
  end
  
  # Delete Action
  delete '/users/:id' do
    user = User.find(params[:id])
    user.delete
  end
  
end