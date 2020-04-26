class UsersController < ApplicationController
  get '/signup' do 
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
  else 
  erb:'/users/login'
  end
end 


post '/login' do
  user = User.find_by(:username => params[:username])
  if user && user.authenticate(params[:password])
    session[:id] = user.id
    redirect to "/tweets"
  else
    redirect to '/signup'
  end
end


get '/users/:slug' do
  @user = User.find_by_slug(params[:slug])
  erb :'users/show'
end

# post '/users/:slug' do
#   @user = User.find_by_slug(params[:slug])
#   erb :'/users/show'
# end
 
get '/logout' do
  if logged_in?
   logout!
  redirect '/login'
  else   
    redirect to '/'
 end 
end 
  
end 