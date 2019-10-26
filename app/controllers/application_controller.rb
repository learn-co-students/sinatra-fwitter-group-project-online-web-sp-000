require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "some_secrete_code"
  end

  get '/' do
    erb :index
  end

  get "/signup" do
    erb :"application/signup"
  end

  post "/signup" do
    erb :"tweets/show"
  end

end
