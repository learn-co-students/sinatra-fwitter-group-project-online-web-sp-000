class TweetsController < ApplicationController
  get '/' do
    if current_user
      erb :"/home"
    else
      redirect to '/login'
    end
  end

    get '/login' do
      erb :'/login'
    end
end
