class TweetsController < ApplicationController

  get '/tweets' do
    if session[:user_id]
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  # before '/tweets/*' do
  #   authentication_required
  # end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/new'
    else
      redirect '/login'
    end
  end

  post "/tweets" do
    if !params[:content].empty?
      @tweet = Tweet.create(content: params[:content], user_id: current_user.id)
      redirect "/tweets/#{@tweet.id}"
    else
      redirect to "/tweets/new"
    end
  end

  get "/tweets/:id" do            #solved our last 3 new action tests
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :"/tweets/show_tweet"
    else
      redirect to "/login"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
        @tweet = Tweet.find(params[:id])
        if @tweet.user_id == current_user.id
            erb :'/tweets/edit_tweet'
        else
        redirect "/tweets"
        end
    else
        redirect "/login"
    end
  end

  #update
  patch '/tweets/:id' do
    @tweet = Tweet.find_by(id: params[:id])
    if params[:content] != ""
      @tweet.update(content: params[:content])
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  delete "/tweets/:id" do
    @tweet = Tweet.find(params[:id])
    if @tweet.user == current_user
      @tweet.delete
      redirect to "/tweets"
    else
      redirect "/tweets/#{@tweet.id}"
    end
  end
#   delete '/tweets/:id/delete' do
#   @tweet = Tweet.find(params[:id])
#   if session[:user_id] == @tweet.user_id
#     Tweet.destroy(params[:id])
#     redirect '/tweets'
#   else
#     redirect '/tweets'
#   end
# end
end
