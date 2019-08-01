class SessionsController < ApplicationController

  get '/login' do
    
    if Helpers.is_logged_in?(session)
      redirect "/tweets"
    else
      erb :'sessions/new'  
    end
  end 

  post '/login' do
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      Helpers.log_in(@user, session)
      redirect to "/tweets"
    end
  end

  get '/logout' do
    if Helpers.is_logged_in?(session)
      Helpers.log_out(session) 
      redirect to '/login'
    else
      redirect to '/'
    end
  end

end