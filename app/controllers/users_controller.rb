
class UsersController < ApplicationController   

  get '/login' do
    @username = ""
    @login = true
    erb :'/users/login'
  end

  post '/login' do    
    user = User.find_by username: params[:username]
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to ('/')
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
