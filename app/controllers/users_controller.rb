class UsersController < ApplicationController

   get '/signup' do 
      if !logged_in?
         erb :'./users/create_user'
      else 
         redirect to "/tweets"
      end 
   end 

   post '/signup' do 
      #raise params.inspect 
      if params[:username] == "" || params[:email] == "" || params[:password] == ""
         redirect to '/signup'
      else 
         #binding.pry 
         @user = User.new
         @user.username = params[:username]
         @user.email = params[:email]
         @user.password = params[:password]
         @user.save 
         session[:user_id] = @user.id 
         redirect to "/tweets"
      end 
   end 

   get '/login' do 
    
      erb :'./users/login'
   end 

   post '/login' do
      #raise params.inspect
      #binding.pry 
      login(params[:email])
      if logged_in?
         redirect to "/tweets"
      end 
   end 

end
