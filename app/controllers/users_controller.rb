require 'sinatra/base'
require 'rack-flash'

class UsersController < ApplicationController

  enable :sessions
  use Rack::Flash

  get '/signup' do

    if Helpers.is_logged_in?(session)
      redirect to '/tweets'
    end

    erb :'users/new_user'

  end

  post '/signup' do

    params.each do |param, input|
      if input.empty?
        redirect to '/signup'
      end
    end

    user = User.create(:username => params["username"], :email => params["email"], :password => params["password"])
    session[:user_id] = user.id
    redirect to '/tweets'

  end

  get '/login' do

    if Helpers.is_logged_in?(session)
      redirect to '/tweets'
    end

    erb :'/users/login'

  end

  post '/login' do

    user = User.find_by(:username => params["username"])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/tweets'
    else
      flash[:login_error] = "Incorrect login. Please try again."
      redirect to '/login'
    end

  end

  get '/users/:slug' do

    slug = params[:slug]
    @user = User.find_by_slug(slug)
    erb :"users/show"

  end

  get '/logout' do

    if Helpers.is_logged_in?(session)
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end

  end

end
