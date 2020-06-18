require './config/environment'
require 'pry'

class ApplicationController < Sinatra::Base
  enable :sessions

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do 
    erb :index
  end

end
