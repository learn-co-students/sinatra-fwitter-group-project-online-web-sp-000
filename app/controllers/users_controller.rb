class UsersController < ApplicationController

  get '/' do
   erb :index
  end

  get '/signup' do
   # if the user is already signed up, redirect to Tweets
   # if the is not signed up- sign up, direct to create user form
   erb :'users/signup'
  end

  post '/signup' do
   # creates a new user


  end

  get '/login' do
   # if a user is already logged in, they will be redirected to Tweets page
   # if the user is not logged in, redirect them to the login page (maybe use an error message)

  end

  post '/login' do
   # create session for logged in user
   # if logged in redirect to Tweets
   # if not logged in redirect to login page

  end

  get '/logout' do
   session.clear

   redirect '/login'
  end

end
