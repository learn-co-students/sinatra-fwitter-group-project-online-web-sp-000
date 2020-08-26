class TweetsController < ApplicationController

    get '/tweets' do
        if logged_in?
          @tweets = Tweet.all
          @user = current_user
          # binding.pry
          erb :'tweets/tweets'
        else
          redirect to '/login'
        end
      end
    
      get '/tweets/new' do
        if logged_in?
          erb :'tweets/create_tweet'
        else
          redirect '/login'
        end
      end
    
      post '/tweets/new' do
        if logged_in?
          if params[:content] != ""
            user = current_user
            tweet = user.tweets.build(content: params[:content])
            user.save
            redirect "/tweets/#{tweet.id}"
          else
            redirect '/tweets/new'
          end
        else
          redirect '/login'
        end
      end
    
      get '/tweets/:id' do
        if logged_in?
          @tweet = Tweet.find(params[:id])
          erb :'tweets/show_tweet'
        else
          redirect '/login'
        end
      end
    
      delete '/tweets/:id/delete' do
        tweet = Tweet.find(params[:id])
        user = User.find(session[:user_id])
        if user.tweets.include?(tweet)
          tweet.delete
          redirect '/tweets'
        else
          redirect "/tweets/#{tweet.id}"
        end
      end
    
      get '/tweets/:id/edit' do
        if logged_in?
          @tweet = Tweet.find(params[:id])
          erb :'tweets/edit_tweet'
        else
          redirect '/login'
        end
      end
    
      patch '/tweets/:id' do
        if params[:content] == ""
          redirect "/tweets/#{params[:id]}/edit"
        else
          tweet = Tweet.find(params[:id])
          tweet.content = params[:content]
          tweet.save
          redirect "/tweets/#{tweet.id}"
        end
      end
    
    end
        

        