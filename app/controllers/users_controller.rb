class UsersController < ApplicationController

   get '/signup' do 

      erb :'./index'
   end 

   post '/signup' do 
      raise params.inspect 
   end 

end
