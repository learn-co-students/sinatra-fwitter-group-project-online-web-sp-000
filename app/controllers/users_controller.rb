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
      if !logged_in?
         erb :'./users/login'
      else 
         redirect to "/tweets"
      end 
   end 

   post '/login' do
      @user = User.find_by(params[:id])
      if @user 
         session[:user_id] = @user.id
         redirect to "/tweets/#{@user.id}"
      else  
         redirect to "/login"
      end
      #binding.pry
   end 

   get '/logout' do 
      session.clear  
      redirect to "/login"
      # lets a user logout if they are already logged in 
      # and redirects to the login page
      # if logged_in? 
      #    session.clear 
      #    redirect to "/login"
      # end 
      # redirects a user to the index page if the user tries 
      # to access /logout while not logged in
      # if request.path == "/logout" && !logged_in?
      #    redirect to "/"
      # end 
      # redirects a user to the login route if a user tries to 
      # access /tweets route if user not logged in
   end 



   get '/tweets/:id' do 
      #binding.pry 
      @user = User.find_by_id(params[:id])

      erb :'./users/show'
   end 


end
