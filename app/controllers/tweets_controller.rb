class TweetsController < ApplicationController
  configure do
    enable :sessions
    set :session_secret, "password_security"
  end
  
  get '/tweets' do
    if session[:user_id]
      @user = User.find(session[:user_id])
      erb :'tweets/index'
    else
      redirect '/login'
    end
  end
  

end
