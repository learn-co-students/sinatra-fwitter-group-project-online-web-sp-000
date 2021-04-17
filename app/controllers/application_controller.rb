require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions
		set :session_secret, "password_security"
  end

  get "/" do
    erb :"index"
  end

end
