require './config/environment'

class ApplicationController < Sinatra::Base



  configure do
    register Sinatra::ActiveRecordExtension
    set :public_folder, 'public'
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

end
