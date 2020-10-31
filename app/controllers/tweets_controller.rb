class TweetsController < ApplicationController

  get '/tweets' do
    authenticate
    @tweets = Tweet.all 
    erb '/tweets/tweets'
  end

  # get '/tweets/new' do  
  
  # end

  # post '/tweets' do
      
  # end

  # get '/tweets/:id' do
    
  # end

  # post '/tweets/:id/delete' do
    
  # end

 
 
end
