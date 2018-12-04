class HomeController < ApplicationController
  # Home action
  get '/' do
    erb :'index'
  end

  get '/signup' do
    erb :'users/create_user'
  end  

end