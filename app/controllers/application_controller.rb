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
    # erb :'tweets/tweets'
  end

  post '/tweets' do
    erb :'tweets/tweets'
  end

end
