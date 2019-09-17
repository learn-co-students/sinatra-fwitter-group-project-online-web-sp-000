class TweetsController < ApplicationController
  get '/tweets' do 
    if is_logged_in?
      @tweets = Tweet.all
      
      erb :tweets
    else

      redirect '/users/login'
    end
  end    

  post '/tweets' do
    if is_logged_in?
      if params[:content] == ""
        
        redirect '/tweets/new'
      else
        @tweet = current_user.tweets.create(content: params[:content]) 

        redirect "/tweets/#{@tweet.id}"
      end
    else
      
      redirect '/users/login'
    end
  end

  get '/tweets/new' do
    if is_logged_in?
    
      erb :'/tweets/new'
    else

      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if is_logged_in?
      @tweet = Tweet.find_by(id: params[:id])

      erb :'/tweets/show'
    else

      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if is_logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      erb :'/tweets/edit'
    else

      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by(id: params[:id])
    if is_logged_in? && current_user == @tweet.user     
      if params[:content] == ""
        
        redirect "/tweets/#{@tweet.id}/edit"
      else 
        @tweet.update(content: params[:content])
      end
        
      redirect "/tweets/#{@tweet.id}"
    else

      redirect '/login'
    end
  end
    
  delete '/tweets/:id/delete' do
    @tweet = Tweet.all.find_by(id: params[:id])
    if is_logged_in? && current_user == @tweet.user  
      @tweet.delete

      erb :tweets
    else

      redirect '/login'
    end
  end

end
