require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  
 #  'enable :sessions' was causing the login to loop in the browser even though all tests were passing. The session was getting cleared from one controller action to the other
 
 # 'use Rack::Session::Cookie' fixed the log in loop and all tests still pass.
 
  
  use Rack::Session::Cookie, :key => 'rack.session',
                           :path => '/',
                           :secret => 'fwitter_is_awesome'
  
  get '/' do 
    erb :'/homepage'
  end 
  
  get '/signup' do 
    redirect '/tweets' if logged_in?
    erb :'/signup'
  end
  
  post '/signup' do 
    params.each do |k, v|
      v.empty? ? redirect('/signup') : next
    end 
    
    user = User.create(params)
    log_in(user)
    redirect '/tweets'
  end 
  
  get '/tweets' do 
    redirect '/login' if !logged_in?
    @user = current_user
    erb :'/tweets'
  end 
  
  get '/login' do 
    logged_in? ? redirect('/tweets') : erb(:'/login')
  end 
  
  post '/login' do 
    user = User.find_by(username: params[:username])
    if user.authenticate(params[:password])
      log_in(user)
      redirect '/tweets'
    else
      redirect '/login'
    end 
  end 
  
  get '/logout' do 
    logged_in? ? logout : redirect('/login')
  end 
  
  helpers do 
    def current_user 
      User.find(session[:user_id])
    end 
    
    def log_in(user) 
      session[:user_id] = user.id
    end 
    
    def logged_in? 
      !!session[:user_id]
    end 
    
    def logout 
      session.clear
      redirect '/login'
    end 
  end 
end