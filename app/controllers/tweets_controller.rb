class TweetsController < ApplicationController

    get '/tweets'  do #read - if user is logged in, will take to '/tweets' , if not logged in, redirects to '/login'
        if session[:user_id] 
            @tweets = Tweet.all 
            erb :'/tweets/tweets'
        else 
            redirect to '/login/'
        end
    end
    
    get "/tweets/new" do  #read - form to create new tweet
        if session[:user_id] 
            erb :'/tweets/new'
        else 
            redirect to '/login/'
        end
    end

    post '/tweets' do #submits and saves tweet that was created
        if session[:user_id]
            if params[:content] == ""
              redirect to "/tweets/new"
            else
              @user = User.find_by_id(session[:user_id])
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
        end

    get '/tweets/:id' do #shows tweets
        if session[:user_id]
            @tweet = Tweet.find_by_id(params[:id])
            erb :'tweets/show_tweet'
          else
            redirect to '/login'
          end
        end

    get '/tweets/:id/edit' do  #form to edit tweet 
        if session[:user_id]
            @tweet = Tweet.find_by_id(params[:id])
            if @tweet && @tweet.user == current_user
              erb :'tweets/edit_tweet'
            else
              redirect to '/tweets'
            end
          else
            redirect to '/login'
          end
        end

    post '/tweets/:id/edit' do  #submits saved tweet and shows result
        if session[:user_id]
            if params[:content] == ""
              redirect to "/tweets/#{params[:id]}/edit"
            else
              @tweet = Tweet.find_by_id(params[:id])
              @user = User.find_by_id(session[:user_id])
              if @tweet && @tweet.user == current_user
                if @tweet.update(content: params[:content])
                  redirect to "/tweets/#{@tweet.id}"
                else
                  redirect to "/tweets/#{@tweet.id}/edit"
                end
              else
                redirect to '/tweets'
              end
            end
          else
            redirect to '/login'
          end
        end

    delete '/tweets/:id/delete' do   #deletes tweet (on tweet show page, as a button)
        if session[:user_id]
            @tweet = Tweet.find_by_id(params[:id])
            if @tweet && @tweet.user == current_user
              @tweet.delete
            end
            redirect to '/tweets'
          else
            redirect to '/login'
          end
        end
    end
