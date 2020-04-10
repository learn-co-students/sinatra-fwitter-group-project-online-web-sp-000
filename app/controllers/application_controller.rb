require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions 
    set :session_secret, "952c62e1ef1e90b73ede1b7b4a68a9ef5663120896559e0eecf8c759b627c06c2bb8ab0ed41877932f413a7aa34887b9f3cbd
    551852a6eefefb15e980de20e9e"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do 

    erb :'./index'
  end 

  # get '/signup' do 

  #   erb :'./index'
  # end 
  helpers do 

    def logged_in? 
      !!current_user 
    end 

    def current_user 
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end 
  end 
end
