require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter_secret"
  end

  #homepage
  get '/' do
    erb :index
  end

  #helper methods
  helpers do
    def current_user
      # Finds the current user, whose id is the same as the session's user_id. Or return nil.
      # Note that #find breaks with an ActiveRecord::RecordNotFound error if it can't find a user, but #find_by_id returns nil.

      # The following code either returns (an already defined) @user or queries the database and stores the result in @user.
      # This prevents multiple unnecessary database queries that would slow down the program.

      # However, when you logout a user in one of the routes, current_user won't be nil until you exit that route.
      # If you want current_user to be nil (while still in the logout route), then omit "@user ||=".

      @user ||= User.find_by_id(session[:user_id])
    end

    def logged_in?
      # Returns a boolean value: true if the user is logged in, false if not.
      # The user is logged in if current_user is truthy (because the session's user_id is not nil).

      !!current_user
    end
  end


end
