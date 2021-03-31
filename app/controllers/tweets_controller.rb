class TweetsController < ApplicationController
    
    get "/tweets" do 
        
        if Helpers.is_logged_in?(session)
        
            erb :'tweets/tweets'

        else

            redirect "/login"

        end
    end

    # get "/tweets/:slug" do

    #     @user = User.find_by_slug(params[:slug])

    #     erb :'/show_tweet'

    # end


end
