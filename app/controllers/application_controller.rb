require './config/environment'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, '70792910aa1a85c895cc44f584d68b1ea707be58084d7426fa97a3f76ff68c2a535454f495836195adb8dc8a278e55adac6bfc69d7d22f187c7a37e3720a38de'
  end

  get '/' do
    erb :welcome
  end

  not_found do
    erb :not_found
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      return @current_user if @current_user # current_user alreadty set.
      return @current_user = User.find_by_id(session[:user_id]) if session[:user_id] # user logged in

      nil # no current user
    end
  end
end
