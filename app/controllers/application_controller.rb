require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter_will_rock_you"
    
  end

  get '/' do   
      erb :index
  end
  
  get '/signup' do 
    if !!Helpers::is_logged_in?(session) == false
      erb :'/users/create_user'
    else
      erb :'/tweets/tweets'
    end
  end 

  post '/signup' do
    if !!Helpers::is_logged_in?(session) == false
      user = User.find_by username: params[:username]
      if user == nil && params[:username] != "" && params[:email] != "" && params[:password] != ""
        user = User.create(username: params[:username], email: params[:email], password: params[:password])    
        session[:user_id] = user.id
        redirect to ('/tweets')
      else
        redirect to ('/signup')
      end
    else
      redirect to ('/tweets')
    end
  end  
end
