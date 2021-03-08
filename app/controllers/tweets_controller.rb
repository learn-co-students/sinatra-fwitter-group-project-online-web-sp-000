class TweetsController < ApplicationController
    
    get '/tweets' do
        if logged_in?
            @tweets = Tweet.all
            erb :'tweets/tweets'
        else
            redirect to '/login'
        end
    end

    get '/tweets/new' do
        if logged_in?
          erb :'tweets/new'
        else
          redirect to '/login'
        end
    end

    post '/tweets' do
        if logged_in?
            if params[:content] == ""
                redirect to '/tweets/new'
            else
                @tweet = Tweet.create(content: params[:content], user_id: current_user.id)
                redirect to "/tweets/#{@tweet.id}"
            end
        else 
            redirect to '/login'
        end
    end

    get '/tweets/:id' do
        if logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            erb :'/tweets/show_tweet'
        else
            redirect to '/login'
        end
    end

    get '/tweets/:id/edit' do
        if logged_in?
          @tweet = Tweet.find_by_id(params[:id])
          if @tweet && @tweet.user == current_user
            erb :'tweets/edit_tweet'
          else
            redirect to '/tweets'
          end
        else
          redirect to '/login'
        end
      end

      patch '/tweets/:id' do
        if logged_in?
          if params[:content] == ""
            redirect to "/tweets/#{params[:id]}/edit"
          else
            @tweet = Tweet.find_by_id(params[:id])
            if @tweet && @tweet.user == current_user
              if @tweet.update(content: params[:content])
                redirect to "/tweets/#{@tweet.id}"
              else
                redirect to "/tweets/#{@tweet.id}/edit"
              end
            else
              redirect to '/tweets'
            end
          end
        else
          redirect to '/login'
        end
      end

      delete '/tweets/:id' do
        if logged_in?
          @tweet = Tweet.find_by_id(params[:id])
          if @tweet && @tweet.user == current_user
            @tweet.destroy
          end
          redirect to '/tweets'
        else
          redirect to '/login'
        end
      end
end
