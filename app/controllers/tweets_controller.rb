class TweetsController < ApplicationController

    get "/tweets" do
      if Helpers.logged_in?(session)
        erb :"tweets/tweets"
      else
        redirect to "/login"
      end
    end

    get "/tweets/new" do
      if Helpers.logged_in?(session)
        erb :"tweets/new"
      else
        redirect to "/login"
      end
    end

    get "/tweets/:id" do
      if Helpers.logged_in?(session)
        @tweet = Tweet.find(params[:id])
        erb :"tweets/show_tweet"
      else
        redirect to "/login"
      end
    end

    get "/tweets/:id/edit" do
      @tweet = Tweet.find(params[:id])
      if @tweet.user == Helpers.current_user(session)
        erb :"tweets/edit_tweet"
      elsif Helpers.logged_in?(session)
        redirect to "/tweets/#{@tweet.id}"
      else
        redirect to "/login"
      end
    end

    post "/tweets" do
      if !params[:content].empty?
        tweet = Tweet.create(content: params[:content], user: Helpers.current_user(session))
        redirect to "/tweets/#{tweet.id}"
      else
        redirect to "/tweets/new"
      end

    end

    patch "/tweets/:id" do
      @tweet = Tweet.find(params[:id])
      # raise params.inspect
      if !params[:content].empty?
        @tweet.update(content: params[:content])
        redirect to "/tweets/#{@tweet.id}"
      else
        redirect to "/tweets/#{@tweet.id}/edit"
      end
    end

    delete  "/tweets/:id" do
      Tweet.find(params[:id]).destroy
      redirect to "/tweets"
    end

end
