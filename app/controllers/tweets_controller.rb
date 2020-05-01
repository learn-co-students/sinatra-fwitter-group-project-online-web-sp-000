class TweetsController < ApplicationController

  get '/tweets' do 
    if logged_in?
      @user = current_user
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end
  
  get '/tweets/new' do 
    erb :new 
  end
  
  post '/tweets' do 
    
  end
  
  get '/tweets/:id' do 
    erb :show_tweet 
  end
  
  get '/tweets/:id/edit' do
    
  end
  
  post '/tweets/:id' do 
    
  end
  
  post '/tweets/:id/delete' do
    
  end

end