class UsersController < ApplicationController

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect to '/tweets/tweets'
    end
  end

end
