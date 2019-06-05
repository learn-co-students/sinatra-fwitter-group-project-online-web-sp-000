require './config/environment'

class ApplicationController < Sinatra::Base
  enable :sessions

  def current_user(session)
    if session[:user_id] != nil
      @current_user = User.find(session[:user_id])
    end
  end

  def logged_in?(session)
    !!session[:user_id]
  end

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end



  get '/' do

  erb :index
  end

end
