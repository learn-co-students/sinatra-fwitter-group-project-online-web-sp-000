class TweetsController < ApplicationController

    get '/tweets' do
        
        if !self.logged_in?
            redirect '/login'
        end

        @user = self.current_user

        erb :'tweets/tweets'
    end

    post '/tweets' do
        
        if (params[:content] == "") || (params[:content] == nil)
            redirect '/tweets/new'
        end


        Tweet.create(content: params[:content], user_id: current_user.id)
        if Tweet.last.id != self.current_user.id
            Tweet.last.destroy
            redirect '/tweets/new'
        end

        redirect "/tweets/#{Tweet.last.id}"
    
    end

    get '/tweets/new' do
        if !self.logged_in?
            redirect '/login'
        end

        erb :'tweets/new'

    end

    get '/tweets/:id' do
        if !self.logged_in?
            redirect '/login'
        end

        @tweet = Tweet.find(params[:id])

        erb :'tweets/show_tweet'
    end

    get '/tweets/:id/edit' do
    
        if !self.logged_in?
            redirect '/login'
        end
        @tweet = Tweet.find(params[:id])
        if self.current_user.id != @tweet.user_id
            redirect '/tweets'
        end
            erb :'tweets/edit_tweet'
        
    end

    patch '/tweets/:id' do
        @tweet = Tweet.find(params[:id])

        if (params[:content] == "") || (params[:content] == nil)
            redirect "/tweets/#{@tweet.id}/edit"
        end
        
        @tweet.update(content: params[:content])
        redirect "/tweets/#{@tweet.id}"
    end

    delete '/tweets/:id' do
        @tweet = Tweet.find(params[:id])
        if self.logged_in? && (self.current_user.id == @tweet.user_id)
            @tweet.destroy
        end
            redirect '/tweets'
    end


end
