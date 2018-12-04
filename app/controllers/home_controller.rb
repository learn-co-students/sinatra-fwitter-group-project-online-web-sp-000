class HomeController < ApplicationController
  # Home action
  get '/' do
    erb :'index'
  end

end