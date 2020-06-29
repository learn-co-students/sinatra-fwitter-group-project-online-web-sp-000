require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    # display the user signup form
    erb :'users/create_user'
  end

  post '/signup' do
    # create the user, save it to database
    # log the user in
    # add the user_id to the sessions hash
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      user = User.create(username: params[username], email: params[:email], password: params[:password])
      session[:user_id] = user.id
      redirect to '/tweets'
    end
  end

  get '/tweets' do
    # tweets index page
    # if a user is not logged in, redirect to '/login'
    @tweets = Tweet.all
  end


end
