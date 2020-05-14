class TweetsController < ApplicationController

    get '/tweets' do
        if !logged_in?
            redirect '/login'
        else
                    @tweets = Tweet.all
        erb :'tweets/tweets' 
        end
    end

    get '/tweets/new' do
        if !logged_in?
            redirect '/login'
        else
            erb :'/tweets/new'
        end
    end

    post '/tweets' do
        if params[:content] == "" || current_user.id != session[:user_id]
            redirect to "/tweets/new"
        else
            @tweet = Tweet.create(content: params[:content], user_id: @current_user.id)
            redirect "/tweets/#{@tweet.id}"
        end
    end

    get '/tweets/:id' do
        if !logged_in?
            redirect '/login'
        end
        @tweet = Tweet.find(params[:id])
        erb :'/tweets/show'
    end

    get "/tweets/:id/edit" do
        @tweet = Tweet.find(params[:id])
        erb :'/tweets/edit'
    end

    patch '/tweets/:id' do
        @tweet = Tweet.find(params[:id])
        binding.pry
        if logged_in?
            if @tweet.user == current_user
                @tweet.update(content: params[:content])
                redirect "/tweets/#{@tweet.id}"
            else
                redirect "/tweets/#{@tweet.id}/edit"
            end
        else
            redirect '/login'
        end
    end

    delete '/tweets/:id/delete' do
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
