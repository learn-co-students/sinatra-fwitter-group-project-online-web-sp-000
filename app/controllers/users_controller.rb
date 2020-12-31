class UsersController < ApplicationController

   get '/signup' do
      if logged_in?
         redirect "/tweets"
      else
         erb :'/users/signup'
      end
   end

   post '/signup' do
      if params[:username].empty? || params[:password].empty? || params[:email].empty?
         redirect "/signup"
      else
         user = User.create(email: params[:email], username: params[:username], password: params[:password])
         session[:user_id] = user.id
         redirect "/tweets"
      end
   end

   get '/login' do
      if logged_in?
         redirect "/tweets"
      else
         erb :'users/login'
      end
   end

   post '/login' do
      user = User.find_by(username: params[:username])
      
      if user && user.authenticate(params[:password])
         session[:user_id] = user.id
         redirect "/tweets"
      else
         redirect "/login"
      end
   end

   get '/logout' do
      if logged_in?
         session.clear
         redirect "/login"
      else
         redirect "/"
      end
   end

end
