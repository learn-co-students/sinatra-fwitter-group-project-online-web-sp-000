require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "{SecureRandom.urlsafe_base64}"
  end

  get '/' do
    erb :'static_pages/home'
  end

end
