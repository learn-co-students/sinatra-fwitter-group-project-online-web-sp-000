require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
		enable :sessions
		set :session_secret, "password_security"
  end
  # index ###################################
  get '/' do
     erb :index
  end
# get and post '/signup' ####################
  get '/signup' do
      if session[:user_id] != nil
         redirect "/tweets"  
      else
        erb :signup
      end
  end

  post '/signup' do
    if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
    user = User.new(:username => params[:username], :password => params[:password], email: params[:email])
      if user.save     
        session[:user_id] = user.id
        redirect "/tweets"
      end
    else
        redirect '/signup'
    end
  
  end
# get and post '/login' ##########################################
  get '/login' do
    if session[:user_id] != nil
        redirect "/tweets"  
     else
       erb :'users/login'
     end
   end

   post '/login' do
    user = User.find_by(:username => params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect "/tweets"
    else
      redirect "/login"
     end
   end
#get '/tweets' ###########################################
  get '/tweets' do
    if session[:user_id] != nil
         @user = User.find_by(id: session[:user_id])
        erb :"tweets/tweets"
    else
        redirect '/login'
    end
end
#get '/logout' ############################################
  get '/logout' do
    session.clear
    redirect '/login'
  end

 post '/logout' do
      session.clear
      redirect '/login'
end

end
