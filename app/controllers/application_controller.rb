require 'rack-flash'

class ApplicationController < Sinatra::Base

  enable :sessions
  use Rack::Flash

  configure do
    set :session_secret, "glyyph"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do

    erb :index

  end

end
