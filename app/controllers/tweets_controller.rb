class TweetsController < ApplicationController

    # _____________ CREATE ______________ 

    get '/tweets/new' do
        if !logged_in?
            redirect '/login'
        else
            erb :'tweets/new'
        end
    end

    post '/tweets' do
        if !logged_in?
            redirect '/login'
        else
            if logged_in? && params[:content] != ""
            @tweet = Tweet.create(content: params[:content])
            @tweet.user_id = current_user.id
            @tweet.save
        redirect "tweets/#{@tweet.id}"
            else
                redirect '/tweets/new'
            end
        end
    end

    # _____________ READ ______________ 
    get '/tweets' do
        if !logged_in?
            redirect '/login'
        else
            @tweets = Tweet.all
            # binding.pry
            erb :'/tweets/tweets'
        end
    end

    get '/tweets/:id' do
        if !logged_in?
            redirect '/login'
        else
            @tweet = Tweet.find_by(id: params[:id])
        erb :'/tweets/show_tweet'
        end
    end

    # _____________ UPDATE ______________ 

    get '/tweets/:id/edit' do
        if !logged_in?
            redirect '/login'
        else
            @tweet = Tweet.find_by_id(params[:id])
            if @tweet && @tweet.user == current_user
                erb :'/tweets/edit_tweet'
            else
                redirect '/tweets'
            end
        end
    end

    patch '/tweets/:id' do
        if !logged_in? #not logged in
            redirect '/login'
        else #logged in
            if params[:content] == "" #can't edit a text that is blank
                redirect "/tweets/#{params[:id]}/edit"
            else
                @tweet = Tweet.find_by_id(params[:id])
                # binding.pry
                if @tweet && @tweet.user == current_user #no edit if not create
                    if @tweet.update(content: params[:content]) 
                        redirect "/tweets/#{@tweet.id}"
                    else
                        redirect "/tweets/#{@tweet.id}/edit"
                    end
                else
                    redirect "/tweets/#{@tweet.id}/edit"
                end
                redirect "/tweets"
            end
        end
    end

    # _____________ DESTROY ______________ 

    delete '/tweets/:id/delete' do
        if !logged_in?
            redirect '/login'
        else
            @tweet = Tweet.find_by(id: params[:id])
                if @tweet && @tweet.user == current_user
                    @tweet.destroy
                    redirect '/tweets'
                else
                    redirect "/tweets/#{@tweet.id}/edit"
                end
        end
    end

end
