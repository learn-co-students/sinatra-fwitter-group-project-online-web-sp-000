require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    "Welcome to Fwitter"
  end

  get '/signup' do
    # 'signup directs user to twitter index'
    redirect to "/tweets/#{@tweet.id}"
  end

  post '/signup' do
    # 'does not let a user sign up without a username'
    # does not let a user sign up without an email'
    # 'does not let a user sign up without a password'
    # 'does not let a logged in user view the signup page'
  end

  get '/login' do
    # 'loads the tweets index after login'
  end

  post '/login' do
    # 'does not let user view login page if already logged in'
  end

  get '/logout' do
    # "lets a user logout if they are already logged in and redirects to the login page"
  end


end
