require './config/environment'

class ApplicationController < Sinatra::Base


  def current_user
    if session[:user_id] != nil
      @current_user = User.all.find_by_id(session[:user_id])
    end
  end

  def logged_in?
    if session[:user_id]
      return true
    end
  end

  configure do
    set :public_folder, 'public'
    enable :sessions
    set :views, 'app/views'
  end



  get '/' do

  erb :index
  end

  get '/signup' do
    if logged_in?
      binding.pry
      redirect '/tweets'
    else
    erb :'/users/create'
    end
  end

end
