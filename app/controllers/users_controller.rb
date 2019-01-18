class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/users/signup'
    end
  end

  post '/signup' do
    if !(params.has_value?(""))
      user = User.create(params)
      session["user_id"] = user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user
        session[:user_id] = user.id
        redirect "/tweets"
     else
        redirect "/signup"
     end
   end

   get '/logout' do
     session.destroy
     redirect '/login'
   end
end
