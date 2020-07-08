require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "geometrical"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    if Helpers.is_logged_in?(session)
      redirect to '/tweets'
    else
      erb :index
    end 
  end
end
