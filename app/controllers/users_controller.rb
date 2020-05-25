class UsersController < ApplicationController

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  get '/signup' do
    if !logged_in?
      #if the user is not logged in then send to new user page
      erb :'users/new', locals: {message: "Please sign up before you sign in"}
    else
      redirect '/tweets'
    end
  end

  post '/signup' do
    #check to see if signup info is empty or not
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect '/signup'
    else
      #if the signup info is not empty then create a new user
      user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect to '/tweets'
    end
  end

  post '/login' do
    #make a new user from the inputs
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      #if the user is authenticated then set the session id correctly
      session[:user_id] = user.id
      redirect to "/tweets"
    else
      #if the user data is not authenticated then send back to the signup page
      redirect to '/signup'
    end
  end

  get '/logout' do
    #check to see if the user is logged in or not in the first place
    if logged_in?
      #if the user is currently logged in then destroy the session
      session.destroy
      redirect to '/login'
    else
      #if the user is not currently logged in then send them back to login or signup page
      redirect to '/'
    end
  end

end
