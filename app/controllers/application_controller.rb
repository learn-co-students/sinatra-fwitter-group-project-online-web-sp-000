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
    user = User.create(params[:user])
    erb :'users/create_user'
    # redirect '/tweets'
    erb :'tweets/tweets'
  end

  get '/tweets' do
    Hello World
  end

  # post '/tweets' do
  #   @user = User.find_by(:username => params[:username])
  #
  #     if @user
  #       session[:user_id] = @user.id
  #       erb :'tweets/tweets'
  #       redirect to '/'
  #     else
  #       erb :error
  #     end
  #   end

end
