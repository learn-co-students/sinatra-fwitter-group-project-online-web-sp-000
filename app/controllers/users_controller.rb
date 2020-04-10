class UsersController < ApplicationController

   get '/signup' do 
      if !logged_in?
         erb :'./users/create_user'
      else 
         redirect "/tweets"
      end 
   end 

   post '/signup' do 
      #raise params.inspect 
      # binding.pry
      @user = User.new 
      if params[:user][:username].empty? || params[:user][:email].empty? || params[:user][:password].empty?
         erb :'./users/create_user'
      else 
         @user.username = params[:user][:username]
         @user.email = params[:user][:email]
         @user.password = params[:user][:password]
         @user.save 
         session[:user_id] = @user.id 
         redirect to "/tweets"
      end 
   end 

end
