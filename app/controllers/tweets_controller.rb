class TweetsController < ApplicationController
    
    get '/tweets' do
        if !logged_in?
          redirect '/login'
        else
            @user = current_user
            @tweets = Tweet.all
            @users = User.all
          erb :'/tweets/tweets'
        end
      end
    


      get '/tweets/new' do
        if !logged_in?
          redirect '/login'
        else
          erb :"tweets/new"
        end
      end

 

      get '/tweets/:id' do
        
        if logged_in?
          @tweet = Tweet.find(params[:id])
          erb :'tweets/show_tweet'
        else
          redirect to '/login'
        end
      end
    
      get '/tweets/:id/edit' do
        if logged_in?
          @tweet = Tweet.find(params[:id])
          erb :'/tweets/edit_tweets'
        else
          redirect "/login"
        end
      end
    

    
      post '/tweets' do
       
        if logged_in?
          if params[:content] == ""
            redirect to 'tweets/new'
          else
            @tweet = current_user.tweets.build(content: params[:content])
            @tweet.save
          
            if @tweet.save
              redirect to "/tweets/#{@tweet.id}"
            else
              redirect '/tweets/new'
            end
          end
        else
          redirect "/login"
        end
      end

      patch '/tweets/:id/edit' do
        if logged_in?
          @tweet = Tweet.find_by(params[:id])
          if !params[:content] == ""
            redirect to "/tweets/#{@tweet.id}/edit"
          else
            @tweet.content = params[:content]
            @tweet.save
          end
        else
          redirect '/login'
        end
      end

      delete '/tweets/:id/delete' do
        if logged_in?
          @tweet = Tweet.find_by_id(params[:id])
          if @tweet.user== current_user
            @tweet.delete
            @tweet.save
            redirect to '/tweets'
        else
          redirect to '/login'
        end
      end
    end
end
