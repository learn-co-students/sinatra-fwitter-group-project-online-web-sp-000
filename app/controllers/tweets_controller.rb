class TweetsController < ApplicationController

    get "/tweets" do
        @tweets = Tweet.all
        
        if logged_in?
          erb :"tweets/index"
        else
          redirect "/login"
        end
    end

    get "/tweets/new" do
        if logged_in?
          erb :"tweets/new"
        else
          redirect "/login"
        end
    end

    post "/tweets" do
        if !params[:content].empty?
           @tweet = Tweet.new(content: params[:content])
           user = User.find(session[:user_id])
           @tweet.user_id = user.id 
           @tweet.save
           erb :"tweets/show"
        else
            redirect "/tweets/new"
        end
    end

    get "/tweets/:id" do
        if logged_in?
          @tweet = Tweet.find(params[:id])
          erb :"tweets/show"
        else
          redirect "/login"
        end
    end

    get '/tweets/:id/edit' do
        if logged_in?
          @tweet = Tweet.find(params[:id])
          @user = @tweet.user
          erb :"tweets/edit"
        else
          redirect "/login"
        end
    end

    patch '/tweets/:id' do 
        @tweet= Tweet.find(params[:id])
    
           if !params[:tweet][:content].empty?
              @tweet.update(params[:tweet])
              redirect "tweets/#{@tweet.id}"
           else
              redirect "tweets/#{@tweet.id}/edit"
           end
        
    end

    delete '/tweets/:id' do
        
        @tweet = Tweet.find(params[:id])
        if @tweet.user_id == session[:user_id]
           Tweet.delete(params[:id])
        end
        redirect to("/tweets")
      end


end
