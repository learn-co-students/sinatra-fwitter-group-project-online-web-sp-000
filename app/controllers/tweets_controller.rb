class TweetsController < ApplicationController

    get "/tweets" do
      if Helpers.logged_in?(session)
        erb :"tweets/tweets"
      else
        redirect to "/login"
      end
    end

    get "/tweet/new" do
      erb :"tweets/new"
    end

    get "/tweet/:id" do
      @tweet = Tweet.find(params[:id])
      erb :"tweets/show_tweet"
    end

    get "/tweet/:id/edit" do
      @tweet = Tweet.find(params[:id])
      erb :"tweets/edit_tweet"
    end

    post "/tweets" do
      tweet = Tweet.create(content: params[:content], user: Helpers.current_user(session))

      redirect to "/tweet/#{tweet.id}"
    end

    patch "/tweet/:id" do
      @tweet = Tweet.find(params[:id])
      # raise params.inspect
      @tweet.update(content: params[:content])
      redirect to "/tweet/#{@tweet.id}"
    end

    delete  "/tweet/:id" do
      Tweet.find(params[:id]).destroy
      redirect to "/tweets"
    end

end
