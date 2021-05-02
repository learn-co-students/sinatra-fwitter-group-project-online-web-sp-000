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
    erb :login
  end

  get '/signup' do 
    erb :signup
  end

  post '/' do 
    user = User.create(params[:user])
    session[:user_id] = user.id 
    redirect "/users/#{user.id}"
    binding.pry
  end


end



