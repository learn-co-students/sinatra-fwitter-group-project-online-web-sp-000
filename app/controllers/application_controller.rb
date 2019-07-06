require './config/environment'
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

  get '/signup' do

    if Helpers.is_logged_in?(session)
      redirect to '/tweets'
    end

    erb :'users/new_user'

  end

  post '/signup' do

    params.each do |param, input|
      if input.empty?
        flash[:new_user_error] = "Please enter a value for #{param}"
        redirect to '/signup'
      end
    end

   user = User.create(:username => params["username"], :email => params["email"], :password => params["password"])
   session[:user_id] = user.id

  redirect to '/tweets'

  end

end
