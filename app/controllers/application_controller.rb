require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :session_secret, "my_application_secret"
    enable :sessions
    set :views, 'app/views'
  end

  get "/" do
    erb :index
  end

end
