require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    use Rack::Flash
    set :session_secret, "{SecureRandom.urlsafe_base64}"
    set :views, Proc.new { File.join(root, "../views/") }
  end

  get '/' do
    erb :'static_pages/home'
  end

end
