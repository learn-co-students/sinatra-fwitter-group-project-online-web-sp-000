class TweetsController < ApplicationController

    # CREATE

    get '/tweets/new' do
        redirect to '/login' unless Helpers.is_logged_in?(session)
        erb :'/tweets/new'
    end

    post '/tweets' do
        user = Helpers.current_user(session)
        tweet = user.tweets.create(params)

        redirect to '/login' if user.nil?
        redirect to '/tweets/new' if !tweet.valid?
        redirect to '/tweets'
    end

    # READ

    get '/tweets' do
        if Helpers.is_logged_in?(session)
            @tweets = Tweet.all
            @user = Helpers.current_user(session)
            erb :'/tweets/index'
        else
            redirect to '/login'
        end
    end

    get '/tweets/:id' do
        redirect to '/login' unless Helpers.is_logged_in?(session) # Would rater user commented line below and not this line, but need to do so to pass spec
        @tweet = Tweet.find(params[:id])
        
        # redirect to '/login' unless @tweet.user == Helpers.current_user(session)
        erb :'/tweets/show'
    end

    # UPDATE

    get '/tweets/:id/edit' do
        redirect to '/login' unless Helpers.is_logged_in?(session) #this seems unnecessary but leaving in to pass spec

        @tweet = Tweet.find(params[:id])
        redirect to "/login" unless @tweet.user == Helpers.current_user(session)
        erb :'/tweets/edit'

    end

    patch '/tweets/:id' do
        tweet = Tweet.find(params[:id])

        redirect to "/tweets/#{tweet.id}" if tweet.update(content: params[:content])
        redirect to "/tweets/#{tweet.id}/edit"
    end

    # DELETE

    delete '/tweets/:id/delete' do

        redirect to '/login' unless Helpers.is_logged_in?(session)

        # tweet = Tweet.find(params[:id])
        # if tweet.user == Helpers.current_user(session)
        #   tweet.delete
        # end
        # redirect to '/tweets' 

        user = Helpers.current_user(session)
        tweet = user.tweets.find_by(id: params[:id])

        tweet.destroy if tweet
        redirect "/tweets" 

    end
end
