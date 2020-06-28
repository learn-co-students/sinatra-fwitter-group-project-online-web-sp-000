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
    
  end


end
