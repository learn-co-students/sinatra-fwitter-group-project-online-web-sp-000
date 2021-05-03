require './config/environment'

class ApplicationController < Sinatra::Base
  enable :sessions
  set :session_secret, "secret_of_evermore"

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do 
    erb :home_page
  end

  get '/login' do 
    if !logged_in?
      erb :login
    else
      redirect '/tweets'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
     session[:user_id] = user.id
     redirect '/tweets'
    else
     redirect to '/login' 
    end
  end

  get '/signup' do 
    if !logged_in?
      erb :signup
    else
      redirect '/tweets'
    end
  end

  post '/signup' do 
    user = User.new(username: params[:username], email: params[:email], password: params[:password])
      if user.save && !user.username.empty? && !user.email.empty?
        session[:user_id] = user.id
        redirect '/tweets'
      else
        redirect '/signup'
      end
  end

  get '/logout' do 
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end


  helpers do 

    def logged_in?
        !!session[:user_id]
    end
    
    def current_user
        User.find(session[:user_id])
    end

    def find_tweet
     Tweet.find(params[:id])
    end

  end

end



