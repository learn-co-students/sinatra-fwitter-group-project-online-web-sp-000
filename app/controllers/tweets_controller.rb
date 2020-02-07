class TweetsController < ApplicationController

    get "/tweets" do
        @tweets = Tweet.all
        erb:"/tweets/index"
    end

    get "/tweets/new" do
        erb:"/tweets/new"
    end

    get "/tweets/:id" do
        @tweet = Tweet.find(params[:id])
       
        erb:"/tweets/show"
    end
   
    post "/tweets" do
       @tweet = Tweet.create(params)
       @tweet.user = Helpers.current_user(session)
       @tweet.save
       redirect to("/tweets/#{@tweet.id}")
    end

    get "/tweets/:id/edit" do
        @tweet = Tweet.find(params[:id])
        if @tweet.user == Helpers.current_user(session)
            erb :"tweets/edit"
          else 
              redirect to("/users/signup")
        end
       
    end

    patch "/tweets/:id" do
        @tweet = Tweet.find(params[:id])
        @tweet.update(params[:tweet])
        redirect to("/tweets/#{@tweet.id}")
    end
    
    delete "/tweets/:id" do

        @tweet = Tweet.find(params[:id])

        if @tweet.user == Helpers.current_user(session)
          @tweet.delete
          redirect to("/tweets")
        else 
            redirect to("/tweets/#{@tweet.id}")
        end
      end
    
end
