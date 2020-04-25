class UsersController < ApplicationController
  get '/signup' do 
    #binding.pry
    if logged_in?
      redirect '/tweets' 
     else
      erb:'/users/create'
    end 
  end 

post '/signup' do
  user = User.create(params)
  session[:id] = user.id
  if user.save
    redirect '/tweets'
  else
    redirect '/signup'
  end
end

get '/login' do
  if logged_in?
   redirect '/tweets' 
  erb:'users/login'
  end
end 

post '/login' do
  redirect '/login' if params[:username] == "" || params[:password] == ""
  login(params[:username], params[:password])
  redirect '/tweets'
end

 
get '/users/:slug' do
  @user = User.find_by_slug(params[:slug].to_s)
  @tweets = []
  Tweet.all.each do |tweet|
  @tweets << tweet if tweet.user_id == @user.id
  end
  erb:'/tweets/show'
end

post '/users/:slug' do
  @user = User.find_by_slug(params[:slug])
  erb :'/users/show'
end
 
get '/logout' do
  
  if logged_in?
    session.clear
  # logout!
  redirect '/login'
  else   
    redirect to '/'
 end 
  # erb:'/logout'
end 
  # delete '/login' do
  #   session[:id] = nil
  #   redirect "/"
  # end









end 