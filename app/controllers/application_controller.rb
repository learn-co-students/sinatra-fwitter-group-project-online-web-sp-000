require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, '87Cdx4Jl'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    erb :signup
  end

end
