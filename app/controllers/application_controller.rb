require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  def is_logged_in?(session_hash)
    !!session_hash[:user_id]
  end

end
