class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
        erb :'/users/create_user'
      else
        redirect '/tweets'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      # @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      # @user.save
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect to '/tweets'
    end
  end

   get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'users/login'
    end
   end
   #worked on some ERB renders to get it going and see page operate

   post '/login' do
     @user = User.find_by(:username => params[:username])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id        #remembers they're logged in via session
        redirect '/tweets'
      else
        redirect '/login'
      end
   end

   get '/logout' do
     if logged_in?
       session.clear    #destroy works as well
       redirect '/login'
     else
       redirect '/'
     end
   end

   get '/users/:slug' do
     @user = User.find_by_slug(params[:slug])
     erb :"/users/show"
   end
end
