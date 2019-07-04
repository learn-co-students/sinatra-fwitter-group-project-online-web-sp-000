class UsersController < ApplicationController

  #-----Create-----

  get '/signup' do
    if !logged_in?
      erb :'/users/create_user'
    else
      redirect '/tweets'
    end
  end

  post '/signup' do
    if params.any?{ |key, value| value == "" }
      redirect '/signup'
    else
      user = User.create(params)
      login(params)
      redirect "/tweets"
    end
  end

  #-----Read-----

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/show/user'
  end


  #-----Update-----
  #-----Destroy-----
  #-----Other-----

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    login(params)
    redirect '/tweets'
  end

  get '/logout' do
    logout
    redirect '/login'
  end

end
