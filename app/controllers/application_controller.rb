require './config/environment'
#require 'rack-flash'

class ApplicationController < Sinatra::Base

  enable :sessions
  #use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

end
