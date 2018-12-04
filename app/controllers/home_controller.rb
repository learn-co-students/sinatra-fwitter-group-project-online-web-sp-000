class HomeController < ApplicationController
  # Home action
  get '/' do
    erb :'index'
  end

  get '/signup' do
    'signup'
  end  

end