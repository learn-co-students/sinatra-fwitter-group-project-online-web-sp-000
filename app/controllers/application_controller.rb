require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    
    set :sessions, true
    enable :sessions
    set :session_secret, "my_application_secret"
  end

  get '/' do
		erb :index
  end

  helpers do

    # returns a boolean if the user is logged in or not
    def logged_in?
      !!current_user
    end

    # # keeps track of the logged in user
    def current_user
      # binding.pry
      User.find_by(id: session[:user_id])
    end

    # # create an authorization helper for edit/delete
    # def authorized_to_edit?(post)
    #   post.user == current_user
    # end

  end

end
