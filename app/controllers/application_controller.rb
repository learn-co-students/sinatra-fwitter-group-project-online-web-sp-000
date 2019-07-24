require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

#  get '/' do
#  if logged in to tweets else index


  # tu ide samo helper methods sa kraja (logged_in?, current user)

end
