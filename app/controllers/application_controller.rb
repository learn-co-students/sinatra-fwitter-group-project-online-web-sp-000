require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

   get '/' do
     erb :index
   end

   get '/login' do

     if !!session[:email]
       redirect to '/tweets'
     else
     erb :"/users/login"
     end
   end

   get '/signup' do
     if !!session[:email]
       redirect to '/tweets'
     else
     erb :'/users/create_users'
     end
   end

   post '/signup' do
     @username = params[:username]
     @password = params[:password]
     @email = params[:email]

     if !@username.empty? && !@password.empty? && !@email.empty?
       @user = User.create(username: :username, password: :password, email: :email)
       session[:email] = @user.email
       redirect '/tweets'
     else
       redirect '/signup'
     end

   end
   post '/login' do
     @user = User.find_by(:email => params[:email])
       if @user && @user.authenticate(params[:password])
         session[:email] = @user.email
         redirect '/tweets'
       else
         redirect '/login'
       end
   end

   get '/tweets' do
     erb :'tweets/index'
   end




end
