class TweetsController < ApplicationController
    get '/tweets' do 
        if logged_in?
            @tweets = Tweet.all
            @user = current_user
            erb :'tweets/tweets'
        else 
            redirect '/login'
        end
    end

    get '/tweets/new' do 
        if logged_in?
            erb :'tweets/new'
        else
            redirect '/login'
        end
    end

    post '/tweets' do 
        if params[:content].empty?
            redirect '/tweets/new'
        else
            @tweet = Tweet.create(user_id: current_user.id, content: params[:content])
            @tweet.save
            redirect to "/tweets/#{@tweet.id}"
        end
    end

    get '/tweets/:id' do 
        if logged_in?
            @tweet = Tweet.find(params[:id])
            erb :'/tweets/show_tweet'
        else
            redirect '/login'
        end
    end

    get '/tweets/:id/edit' do
        if logged_in? 
            @tweet = Tweet.find_by(id: params[:id])
            if @tweet && @tweet.user == current_user
                erb :'tweets/edit_tweet'
            else
                redirect '/tweets'
            end
         else
            redirect '/login'
         end
    end

    patch '/tweets/:id' do
        @tweet = Tweet.find(params[:id])
        if !params[:content].empty?
          @tweet.update(content: params[:content])
          redirect "/tweets/#{@tweet.id}"
        else
          redirect "/tweets/#{@tweet.id}/edit"
        end
      end

    delete '/tweets/:id' do
        @user = User.find_by(username: params[:username])
        if logged_in?
            @tweet = Tweet.find_by(id: params[:id])
            if @tweet && @tweet.user_id == @user.id
                @tweet.destroy
                @tweet.delete
            end
            redirect '/tweets'
        else
            redirect '/login'
        end
    end
end