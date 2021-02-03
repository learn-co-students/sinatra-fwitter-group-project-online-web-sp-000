class UsersController < ApplicationController

  get '/signup' do
    if Helpers.is_logged_in?(session)
      redirect '/tweets'
    else
      erb :'users/signup'
    end

  end

  post '/signup' do
    if !params[:username].blank? && !params[:email].blank?
      user = User.new(username: params[:username], email: params[:email], password: params[:password])
    else
      redirect "/signup"
    end

    if user && user.save
      session[:user_id] = user.id
      redirect "/tweets"
      else
        redirect "/signup"
      end
  end

  get '/login' do
    if Helpers.is_logged_in?(session)
      redirect '/tweets'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/logout' do
      session.clear
      redirect '/login'
  end

  get '/users/:slug' do
    @user = User.find_by(username: params[:slug])

    erb :'users/show'
  end

end
