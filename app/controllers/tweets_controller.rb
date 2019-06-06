class TweetsController < ApplicationController

    get '/tweets' do
        if logged_in? 
          erb :'/tweets/tweets'
        else
          redirect '/login'
        end 
    end
    
    get  '/tweets/new' do
        if logged_in? 
            erb :'/tweets/new'
          else
            redirect '/login'
          end 
    end

    post '/tweets' do
        if params[:content] != "" 
            tweet = Tweet.new(params)
            current_user.tweets << tweet
            current_user.save
            redirect '/tweets'
        else
            redirect '/tweets/new'
        end
    end

    get '/tweets/:id' do
       if logged_in? 
            if  @tweet = Tweet.find_by(:id => params[:id])
                erb :'/tweets/show_tweet'
            else
                redirect '/tweets'
            end
        else
            redirect '/login'
        end
    end

    get '/tweets/:id/edit' do
        if logged_in?
            @tweet=Tweet.find(params[:id])
            erb :'/tweets/edit_tweet'
        else
            redirect '/login'
        end
      end
    
    patch '/tweets/:id' do
     if params[:content]  == ""
        redirect "/tweets/#{params[:id]}/edit"
     else
        @tweet=Tweet.update(params[:id], :content=>params[:content])
        erb :'/tweets/show_tweet'
     end
    end

    delete '/tweets/:id/delete' do
       if current_user.tweets.include?(Tweet.find(params[:id]))
          Tweet.destroy(params[:id])
       end
        redirect '/tweets'
    end
    
end
