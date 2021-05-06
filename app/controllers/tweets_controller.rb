class TweetsController < ApplicationController

get '/tweets' do 
    if logged_in? 
        @user = User.find(session[:user_id])
        @tweets = Tweet.all 
        erb :"tweets/tweets"
    else 
        redirect "/login"
    end 
end 

get '/tweets/new' do 
    if logged_in? 
        @user = current_user
         erb :"tweets/new"
    else 
        redirect "/login"
end 
end 

post '/tweets' do 
    @user = current_user
    if !params[:tweet][:content].empty?
        @user.tweets.create(params[:tweet])
    else 
    redirect '/tweets/new'
    end 
end 

get '/tweets/:id' do 
    if logged_in?
        @tweet = Tweet.all.find(params[:id])
    erb :"tweets/show"
    else 
        redirect "/login"
    end
end 

get '/tweets/:id/edit' do 
    if logged_in?
        @tweet = Tweet.all.find(params[:id])
    erb :'tweets/edit'
    else 
       redirect "/login"
    end 
end 

patch '/tweets/:id' do 
    @tweet = Tweet.find(params[:id])
    if !params[:tweet][:content].empty?
        @tweet.update(params[:tweet])
        redirect "/tweets/#{@tweet.id}"
        else 
            redirect "/tweets/#{@tweet.id}/edit"
        end 
    binding.pry 
    end 


    delete '/tweets/:id/delete' do
        @tweet = Tweet.find(params[:id])
        if logged_in? && @tweet.user_id == current_user.id
             @tweet.delete
        redirect "/tweets"
        else 
        redirect "/tweets/#{@tweet.id}"
    end 
end
end 