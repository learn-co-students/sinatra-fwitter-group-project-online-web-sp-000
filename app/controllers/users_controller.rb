
class UsersController < ApplicationController   

  get '/users/:id' do       
    erb :'/tweets'
  end
  get '/login' do
    if !!Helpers::is_logged_in?(session) == false
      @username = ""
      @login = true
      erb :'/users/login'
    else      
      erb :'/tweets/tweets'
    end
  end

  post '/login' do    
    user = User.find_by username: params[:username]
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to ('/tweets')
    else
      if user
        @username = user.username
      end
      erb :'/users/login'
    end
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end

end
