class TweetsController < ApplicationController

    get '/tweets' do
        if logged_in?
            #@tweets=Tweet.all
        erb :'/tweets/index'
        else
            redirect "/login"
        end
    end

    post '/tweets' do
        @tweet=Tweet.new(:content => params[:content])
        if @tweet.content != ""
            @tweet.user_id=current_user.id
            @tweet.save
            redirect '/tweets'
        else
            redirect ("/tweets/new")
        end
    end

    get '/tweets/new' do
        if !logged_in?
            redirect "/login"
        else
            erb :'/tweets/new'
        end
    end

    get '/tweets/:id' do
        if logged_in?
          @tweet=Tweet.find_by(:id => params[:id])
          erb :'/tweets/show'
        else
            redirect "/login"
        end
    end

    get '/tweets/:id/edit' do
        if logged_in?
        @tweet=Tweet.find_by(:id => params[:id])
        erb :'/tweets/edit'
        else
            redirect "/login"
        end
    end

    patch '/tweets/:id' do
        if logged_in?
          @tweet = Tweet.find_by_id(params[:id])
            if params[:content] == ""
                redirect "/tweets/#{@tweet.id}/edit"
            else
                @tweet.update(content: params[:content])
                redirect to "/tweets/#{@tweet.id}"
            end
        else
            redirect "/login"
        end
        
    end

    delete '/tweets/:id/delete' do
        @tweet=Tweet.find_by(:id => params[:id])
        if logged_in? && @tweet.user_id == current_user.id
          @tweet.delete
          redirect "/tweets"
        else
            redirect "/login"
        end
    end
end
