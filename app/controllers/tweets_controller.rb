class TweetsController < ApplicationController

get '/tweets' do 
@tweets = Tweet.all 
    if logged_in? 
        erb :"/tweets/index"
    else 
        redirect to "/login"
    end 
end 

get '/tweets/new' do 
erb :"/tweets/new"
end 

post '/tweets' do 
    @tweet = Tweet.create(params)
    @tweet.user_id = current_user.id
    if @tweet.save 
    redirect to "/tweets/#{@tweet.id}"
    else 
    redirect to "/tweets/new"
    end 
end 

get '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    @user = User.find(@tweet.user_id)
erb :"/tweets/show" 
end 

get '/tweets/:id/edit' do 
    @tweet = Tweet.find(params[:id])
erb :"/tweets/edit"
end 

patch '/tweets/:id' do 
if @tweet.user_id = current_user.id 
    @tweet = Tweet.find(params[:id])
    @tweet.content = params[:content]
    @tweet.save
    redirect to "/tweets/#{@tweet.id}"
else 
    redirect to "/tweets/#{@tweet.id}"
end 
end 


delete '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
end 

end
