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
      if params[:username].empty? || params[:email].empty? || params[:password].empty?
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

end
