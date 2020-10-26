class TweetsController < ApplicationController

    get '/tweets' do
        if logged_in?
            @user = @current_user
            @tweets = Tweet.all
            erb :"tweets/index"
        else
            redirect '/login'
        end
    end

    get '/tweets/new' do
        if logged_in?
            erb :'/tweets/new'
        else
            redirect '/login'
        end
    end

    get '/tweets/:id' do
        if logged_in?
            @tweet = Tweet.find_by(:id => params[:id])
            erb :'/tweets/show'
        else
            redirect '/login'
        end
    end

    get '/tweets/:id/edit' do
        @tweet = Tweet.find_by(:id => params[:id])

        if !logged_in?
            redirect '/login'
        elsif @tweet.user_id === current_user.id
            erb :'/tweets/edit'
        else
            redirect "/tweets/#{@tweet.id}"
        end
    end

    patch '/tweets/:id' do
        @tweet = Tweet.find_by(:id => params[:id])

        if params[:content].empty?
            redirect "/tweets/#{@tweet.id}/edit"
        elsif @tweet.update(:content => params[:content])
            redirect "/tweets/#{@tweet.id}"
        end
    end

    post '/tweets' do
        if params[:content].empty?
            redirect '/tweets/new'
        else
            @tweet = Tweet.new(:content => params[:content])
            @tweet.user_id = session[:user_id]
            @tweet.save
            redirect "/tweets/#{@tweet.id}"
        end
    end

    delete '/tweets/:id/delete' do
        @tweet = Tweet.find_by_id(params[:id])

        if logged_in? && (@tweet.user_id === current_user.id)
            @tweet.delete
            redirect '/tweets'
        else
            redirect '/login'
        end
      end

end
