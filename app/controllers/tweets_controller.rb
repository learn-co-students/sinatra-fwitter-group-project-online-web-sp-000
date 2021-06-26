class TweetsController < ApplicationController

get '/tweets' do
  if logged_in?
    @tweets = Tweet.all
    @user = User.find_by(username: params[:username])
    erb :'tweets/tweets'   
  else
    redirect '/login'
  end
end

get '/tweets/new' do 
  if logged_in?
    erb :'tweets/new'
  else
    redirect '/login'
  end
end

post '/tweets' do 
  if logged_in?
    if params[:content] == ""
      redirect to '/tweets/new'
    else
      @tweet = Tweet.create(content: params[:content], user_id: @user.id)
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    end
  else 
    redirect '/login'
  end
end

get '/tweets/:id' do 
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      erb :'tweets/show_tweet'
    else 
      redirect '/login'
    end
end

get '/tweets/:id/edit' do 
  if logged_in? 
    @tweet = Tweet.find_by(id: params[:id])
    
    if @tweet && @tweet.user == current_user
      erb :'tweets/edit_tweet'
    else
      redirect '/tweets'
    end
    
   else
      redirect '/login'
   end
end

patch '/tweets/:id' do 
  if logged_in?
    if params[:content] == ""
      redirect to "/tweets/#{params[:id]}/edit"
    else
      @tweet = Tweet.find_by_id(params[:id])
      
      if @tweet && @tweet.user_id == current_user.id
        @tweet.update(content: params[:content])
        @tweet.save
        redirect to "/tweets/#{@tweet.id}"
      else 
        redirect '/tweets/:id'
      end
    end
  end
end

delete '/tweets/:id' do
  @user = User.find_by(username: params[:username])
  if logged_in?
    @tweet = Tweet.find_by(id: params[:id])
    if @tweet && @tweet.user_id == @user.id
      @tweet.destroy
      @tweet.delete
    end
    redirect '/tweets'
  else
    redirect '/login'
  end
end
end
