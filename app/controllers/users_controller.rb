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
         #binding.pry
         session[:user_id] = @user.id 
         redirect to "/tweets"
      end 
   end 

   get '/login' do 
      if !logged_in?
         erb :'users/login'
      else 
         redirect to "/tweets"
      end 
   end 

   post '/login' do
      @user = User.find_by(:username => params[:username])
      #binding.pry 
      #raise params.inspect
      if @user && @user.authenticate(params[:password])
         session[:user_id] = @user.id
         redirect to "/tweets"
      else  
         redirect to "/signup"
      end
      #binding.pry
   end 

   get '/logout' do 
      session.clear  
      redirect to "/login"
   end 


   # get '/tweets/:id' do 
   #    #binding.pry 
   #    @user = User.find_by_id(params[:id])

   #    erb :'./users/show'
   # end 


end
