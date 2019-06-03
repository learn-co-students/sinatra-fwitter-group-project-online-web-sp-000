require './config/environment'

class ApplicationController < Sinatra::Base


  def current_user
    if session[:id] != nil
      User.all.find_by_id(session[:id])
      binding.pry
    end
  end

  def logged_in?
    if session[:id] != nil
      session[:id] = current_user.id
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

  erb :'/users/create'
  end

end
