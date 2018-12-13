class UsersController < ApplicationController

  get '/signup' do
    erb :'/users/signup'
  end

  post '/signup' do
  end

  get '/login' do
  end

  post '/login' do
  end

  get '/logout' do
    redirect '/login'
  end

end
