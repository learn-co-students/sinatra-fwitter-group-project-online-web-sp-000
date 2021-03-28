require './config/environment'
require 'rack-flash'
class ApplicationController < Sinatra::Base

  configure do
    #register Sinatra::ActiveRecordExtension
    enable :sessions
    use Rack::Flash
    #register Sinatra::Flash
    set :session_secret, "password_security"
    set :public_folder, 'public'
    set :views, 'app/views'
  
  end
  
  get '/' do
    erb :index
  end

  get '/index' do
    erb :index
  end

  # helpers do
  #   def logged_in?
  #     !!session[:user_id
  #   end
  
  #   def current_user
  #     User.find(session[:user_id])
  #   end
  # end

end
