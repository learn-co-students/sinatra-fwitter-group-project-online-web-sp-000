class TweetsController < ApplicationController

    get "/tweets" do
        if is_logged_in? 
            @tweets = Tweet.all
            erb :'/index'
        else
            redirect to '/login'
        end
    end

    get "/tweets/new" do
        if is_logged_in?  
           erb :'/tweets/new'
        else
           redirect to '/login'
        end
    end

    post "/tweets" do
        if is_logged_in?
          if params[:content] == ""
            redirect to "/tweets/new"
          else
            @tweet = current_user.tweets.build(content: params[:content])
            if @tweet.save
              redirect to "/tweets/#{@tweet.id}"
            else
              redirect to "/tweets/new"
            end
          end
        else
          redirect to '/login'
        end
      end

    get "/tweets/:id" do
        if is_logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            erb :'/tweets/show'
        else
            redirect to '/login'
        end
    end

    get "/tweets/:id/edit" do
            if is_logged_in? && params[:content] == "" && @tweet && @tweet.user == current_user
                @tweet = Tweet.find_by_id(params[:id])
                
                erb :"/tweets/#{@tweet.id}/edit"
            else
                redirect to '/login'
        end
    end
 

    delete "/tweets/:id/delete" do
        if is_logged_in?
          @tweet = Tweet.find_by_id(params[:id])
          if @tweet && @tweet.user == current_user
            @tweet.delete
          end
          redirect to '/tweets'
        else
          redirect to '/login'
        end
    end

end



