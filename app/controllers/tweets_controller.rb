class TweetsController < ApplicationController

    get '/tweets' do 
        if current_user(session)
        #binding.pry
            @user = current_user(session)
            @tweets = Tweet.all
            @users = User.all
        #binding.pry
            erb :'tweets/tweets'
        else
            redirect to "/login"
        end
    end

    get '/tweets/new' do
        if current_user(session)
            erb :'/tweets/new'
        else
            redirect to "/login"
        end
    end

    post '/tweets' do
        if current_user(session) && params["content"] != ""
            @user = current_user(session)
            @tweet = Tweet.new(:content => params[:content])
            @tweet.user_id = @user.id
            @user.tweets << @tweet 
            @tweet.save
            #binding.pry
            redirect to "/tweets/#{@tweet.id}"
        else
            redirect to "/tweets/new"
        end
    end

    get '/tweets/:id' do
        if current_user(session)
            @user = current_user(session)
            @tweet = current_tweet(params[:id])
            @tweet.user_id = @user.id
            #binding.pry
            erb :'/tweets/show_tweet'
        else
            redirect to "/login"
        end
    end

    get '/tweets/:id/edit' do
        if current_user(session)
            @user = current_user(session) 
            @tweet = Tweet.find_by_id(params[:id])
            #binding.pry
            erb :'/tweets/edit_tweet'
        else
            redirect to "/login"
        end
    end

    patch '/tweets/:id' do
        # binding.pry
        if current_user(session)
            if params["content"] == ""
                # binding.pry
                @tweet = Tweet.find_by_id(params[:id])
                @tweet.content = params["content"]
                @tweet.save
                redirect to "/tweets/#{@tweet.id}/edit"
            else
            # if current_user(session) && params["content"] != ""
            #     #binding.pry
                @tweet = Tweet.find_by_id(params[:id])
                @user = current_user(session)
                @tweet.content = params["content"]
                @tweet.save
            #     #flash[:message] = "Successfully updated tweet."
                erb :'/tweets/show_tweet'
            #     #flash[:message] = "Your tweet was empty."
            end
        end
    end

    post '/tweets/:id/delete' do
        if logged_in?(session)
            @tweet = Tweet.find_by_id(params[:id])
            if @tweet && current_user(session) == @tweet.user
                @tweet.destroy
                redirect to "/tweets"
            end 
        end
    end
end
