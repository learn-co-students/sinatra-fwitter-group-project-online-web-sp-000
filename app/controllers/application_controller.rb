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
     erb :"/users/login"
   end

   get '/signup' do
     erb :'users/create_users'
   end

   post '/signup' do
     @username = params[:username]
     @password = params[:password]
     @email = params[:email]

     if !@username.empty? && !@password.empty? && !@email.empty?
       @user = User.create(username: :username, password: :password, email: :email)
       redirect '/tweets/index'
     else
       redirect '/signup'
     end

   end
   post '/login' do
      @user = login(params[:email], params[:password])
       redirect '/tweets/index'
   end



  def logged_in?
    !!session[:email]
  end

  def login(email, password)
    user = User.find_by(:email => email)
    if user && user.authenticate(password)
      session[:email] = user.email
    else
      redirect '/login'
    end
  end

end
