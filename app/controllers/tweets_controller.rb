class TweetsController < ApplicationController

    get '/tweets' do
        if logged_in?
            @tweets = Tweet.all
            @user = User.find_by_id(session['user_id'])
            erb :'tweets/tweets'
        else
            redirect to("/login")
        end
    end

    get '/tweets/new' do
        if logged_in?
            @user = User.find_by_id(session['user_id'])
            erb :'tweets/new'
        else
            flash[:message] = "You Must Be Logged in to Make Tweets"
            redirect to("/login")
        end
    end

    post '/tweets' do
        @user = User.find_by_id(session['user_id'])
        if params[:content].empty?
            flash[:message] = "You Cannot Create a Blank Tweet"
            redirect to("/tweets/new")
        else
            @tweet = Tweet.create(content: params[:content], user_id: @user.id)
        end
        @tweet.save
        redirect to("/tweets/#{@tweet.id}")
    end

    get '/tweets/:id' do
        if logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            erb :'tweets/show_tweet'
        else
            flash[:message] = "You Must Be Logged In to View a Tweet"
            redirect to("/login")
        end
    end

    get '/tweets/:id/edit' do
        if logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            if @tweet.user_id == current_user.id
                erb :"tweets/edit_tweet"
            else
                flash[:message] = "You Can Only Edit Your Own Tweets"
                redirect to("/tweets")
            end 
        else
            flash[:message] = "You Must Be Logged In to Edit a Tweet"
            redirect to("/login")
        end
    end

    patch '/tweets/:id' do
        @tweet = Tweet.find_by_id(params[:id])
        if params[:content].empty?
            flash[:message] = "You Cannot Create a Blank Tweet"
            redirect to("/tweets/#{@tweet.id}/edit")
        else
            @tweet.content = params[:content]
        end
        @tweet.save
        redirect to("/tweets/#{@tweet.id}")
    end

    delete '/tweets/:id/delete' do
        if logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            if @tweet.user_id == current_user.id
                Tweet.find(@tweet.id).destroy
                flash[:message] = "Tweet Deleted"
                redirect to("/tweets")
            else
                flash[:message] = "You Can Only Delete Your Own Tweets"
                redirect to("/tweets")
            end
        end
    end

end
