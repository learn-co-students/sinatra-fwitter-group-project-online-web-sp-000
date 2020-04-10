class UsersController < ApplicationController

   get '/signup' do 

      erb :'./users/create_user'
   end 

   post '/signup' do 
      raise params.inspect 
   end 

end
