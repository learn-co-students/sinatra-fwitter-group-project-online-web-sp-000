class TweetsController < ApplicationController
    get '/tweets' do
        if logged_in?
            @tweets = Tweet.all
            erb :'/tweets/index'
		else
			redirect "/login"
		end  
      end

      get '/tweets/new' do 
        if logged_in?
            erb :'/tweets/new'
		else
			redirect "/login"
		end         
      end      

      post '/tweets' do 
        if params[:content].length > 0
            @tweet = Tweet.create(:content => params[:content], :user_id => current_user.id)
            @tweet.save
            redirect "/tweets"
        else
            redirect "/tweets/new"
        end
      end  
      
      get '/tweets/:id' do
        if logged_in?
            @tweet = Tweet.find(params[:id])
            erb :'/tweets/show'
		else
			redirect "/login"
		end          
      end 

      get '/tweets/:id/edit' do 
        if logged_in?
            @tweet = Tweet.find(params[:id])
            if current_user.id == @tweet.user_id
                erb :'/tweets/edit'
            else
                redirect "/login"
            end
		else
			redirect "/login"
		end         
      end  
    
      patch '/tweets/:id' do
        @tweet = Tweet.find(params[:id])
        if params[:content].length > 0
            @tweet.update(:content => params[:content])   
            @tweet.save
            redirect "/tweets/#{@tweet.id}"
        else
            redirect "/tweets/#{@tweet.id}/edit"
        end
      end 

      delete '/tweets/:id' do #delete action
        @tweet = Tweet.find_by_id(params[:id])
        if current_user.id == @tweet.user_id
            @tweet.delete
        end
        redirect to '/tweets'
      end

end
