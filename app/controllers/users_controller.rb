
class UsersController < ApplicationController

  ##### SIGNUP #####
  get '/signup' do #display the user signup
    if !logged_in?
      erb :'users/signup'
    else
      redirect '/tweets'
    end
  end

  post '/signup' do 
    @user = User.create(username: params[:username], email: params[:email], password: params[:password])
    if @user.valid?
      session[:user_id] = @user.id #loggs user in
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  ##### LOGIN #####
  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect '/tweets'
    end
  end

  post '/login' do 
    @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect '/tweets'
        else
            flash[:error] = "You must have a user name and a password to login"
            redirect '/signup'
        end
    end

  ##### LOGOUT #####
    get '/logout' do
      if logged_in?
        session.clear
        redirect '/login'
      else
        redirect '/'
      end
    end
 

##### READ #####
    get "/users/:id" do 
      erb :'users/show' 
    end



end
