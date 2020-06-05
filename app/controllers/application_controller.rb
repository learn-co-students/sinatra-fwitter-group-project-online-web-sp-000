require './config/environment'

class ApplicationController < Sinatra::Base
 
  # configure :development do
  #   disable :show_exceptions
  # end
  configure do
    enable :sessions
    set :session_secret, "secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    erb :index
  end
end
