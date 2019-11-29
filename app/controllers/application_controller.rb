require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    erb :index
  end

  helpers do
    def logged_in?
      !!current_user  #!!session[:user_id] instead of using !!session[:user_id] current_user is memoized
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]  #added @current_user to fix this method and store the result of User.find using conditional assignment to an instance variable.
    end                                                               #It makes sense because you want to reduce the time the program runs through all the users to get the desired results.
  end                                                                 #Calling current_user multiple times and you want to use this method to hit the db once and 'cache' the user instance
                                                                      #into an instance variable that could be returned on any subsequent call to current_user.
end
