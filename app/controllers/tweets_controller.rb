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
        #load create tweet form :new
    end

    post '/tweets' do 
        if logged_in?
            if params[:content] == ""
              redirect to "/tweets/new"
            else
              @tweet = current_user.tweets.build(content: params[:content])
              if @tweet.save
                redirect to "/tweets/#{@tweet.id}"
              else
                redirect to "/tweets/new"
              end
            end
          else
            redirect to '/login'
          end
        #create and save database
        #redirects to show
    end

    get '/tweets/:id' do
        #displays information for a single tweet :show
    end


    get '/tweets/:id/edit' do
        #if user logged in
        #loads :edit form
    end

    post '/tweets/:id' do
        #if user logged in
        #updates tweet info
    end

    post '/tweets/:id/delete' do 
        #if user logged in
        #responds to delete form on tweet show page, deletes tweet
    end

end
