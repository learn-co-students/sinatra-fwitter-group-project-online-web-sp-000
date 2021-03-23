require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :layout
  end

  get '/login' do
    erb :login
  end

  get '/signup' do
    erb :signup
  end

end
