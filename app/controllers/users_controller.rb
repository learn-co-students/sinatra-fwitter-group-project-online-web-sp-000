class UsersController < ApplicationController



  get '/signup' do
    if session[:user_id]
      # binding.pry
      redirect "/tweets"
    else 
      erb :'users/new'
    end 
  end 


  post '/signup' do
      # binding.pry
    if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
      # binding.pry
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
        # binding.pry
        session[:user_id] = @user.id
    else 
      redirect '/signup'
    end 
    #create session id 
    if @user.save
        redirect '/tweets'
   end
    # if signup doesn't work, then send them back to signup 
  end 

  get '/login' do 
    # binding.pry 
      if logged_in?
        redirect '/tweets'
      else 
        # erb :'users/new'
        erb :'users/login'
      end 

  end 

  post '/login' do 
    # binding.pry
    @user = User.find_by(username: params[:username])
    # session[:id] = @user.id
        # binding.pry
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    else 
      redirect "/login"
    end 
  end 

  get '/logout' do 
    # binding.pry
    # if current_user?
    if session[:user_id]
      session.clear
      puts "you've been logged out"
      redirect "/login"
    else
      redirect "/"
    end 
  end 

  get "/users/:id" do 
    # binding.pry
    @user = User.find_by(params[:user_id]).tweets
    erb :show
  end 

end