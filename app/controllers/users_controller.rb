class UsersController < ApplicationController
use Rack::Flash

  get '/signup' do
      if session[:user_id] == nil
        erb :'users/signup'
      else redirect "/tweets"
      end
  end

  post '/signup' do
    #binding.pry
      if params[:username] == "" || params[:email] == "" || params[:password] == ""
        flash[:message] = "Please register with a Username and Email and Password."#raise error
        redirect "/signup"
      else
        @user = User.new(username: params["username"], email: params["email"], password: params["password"])
        @user.save
        session[:user_id] = @user.id
        #binding.pry
        redirect '/tweets'
      end
  end

  get '/login' do
    if logged_in?
      redirect to "/tweets"
    else
      erb :'/users/login'  #if user is not logged in loads login erb and redirects to tweets index
    end
  end

  post '/login' do
    #binding.pry
    @user = User.find_by(username: params[:username])
    if @user.id != nil && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect "/tweets"
    else
      flash[:message] = "Your username or password was incorect."
      redirect "/signup"
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

  #shows all a single users tweets (no login needed?)
  get '/users/:slug' do
    #binding.pry
    @user = User.find_by(username: params[:slug])
    erb :'users/show'
  end
end
