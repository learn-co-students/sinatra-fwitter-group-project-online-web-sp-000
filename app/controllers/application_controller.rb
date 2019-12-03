require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  def current_user(session_hash)
    @user = User.find(session_hash[:user_id])
  end

  def is_logged_in?(session_hash)
    !!session_hash[:user_id]
  end

end
