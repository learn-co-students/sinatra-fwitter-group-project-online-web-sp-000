require 'rack-flash'
require 'pry'

class TweetsController < ApplicationController
    use Rack::Flash

    before '/tweets/*' do
        authentication_required
    end

    get '/tweets' do
        @user = User.find_by_id(session[:user_id])
        if logged_in?
            erb :'/tweets/tweets'
        else
            redirect '/login'
        end
    end

    get '/tweets/new' do
        erb :'/tweets/new' 
    end

    post '/tweets' do
        @tweet = current_user.tweets.create(:content => params[:content])
        erb :"/tweets/tweets"
    end

    get '/tweets/:id' do
        @tweet = Tweet.find_by_id(params[:id])
        if logged_in?
            erb :'/tweets/show_tweet'
        else
            redirect '/login'
        end
    end

    get '/tweets/:id/edit' do
        @tweet = Tweet.find_by_id(params[:id])
        if @tweet.user == current_user
            erb :'/tweets/edit_tweet'
        else
            flash[:message] = "Only #{@tweet.user.username} can edit this tweet"
            erb :'/tweets/tweets'
        end
    end

    patch '/tweets/:id' do
        @tweet = current_user.tweets.find(params[:id])
        if @tweet
            @tweet.update(:content => params[:content])
            erb :"/tweets/tweets"
        else
            redirect "/tweets/#{@tweet.id}/edit_tweet"
        end
    end

    delete '/tweets/:id' do
        @tweet = Tweet.find_by_id(params[:id])
        if @tweet.user == current_user
            @tweet.destroy
            redirect '/tweets'
        else
            flash[:message] = "Not your tweet to delete"
            erb :"/tweets/tweets"
        end
    end

end
