class UsersController < ApplicationController

get '/users/login' do
  erb :"/users/login"
end

get '/users/signup' do
  erb :'users/create_users'
end

end
