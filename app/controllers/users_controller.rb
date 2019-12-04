

class UsersController < ApplicationController

  get '/' do
    erb :index
  end

  get '/signup' do

    if is_logged_in?(session)
      redirect to '/tweets'
    end

    erb :'users/create_user'
  end

  post '/signup' do
    params.each do |label, input|
      if input.empty?
        redirect to '/signup'
      end
    end
    user = User.create(:username => params["username"], :email => params["email"], :password => params["password"])
    session[:user_id] = user.id

    redirect to '/tweets'
  end

  get '/login' do
    if is_logged_in?(session)
      redirect to '/tweets'
    end

    erb :"/users/login"
  end

  post '/login' do
    user = User.find_by(:username => params["username"])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/tweets'
    else

      redirect to '/login'
    end
  end

  get '/users/:slug' do
    slug = params[:slug]
    @user = User.find_by_slug(slug)
    erb :"users/show"
  end

  get '/logout' do
    if is_logged_in?(session)
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end
end
