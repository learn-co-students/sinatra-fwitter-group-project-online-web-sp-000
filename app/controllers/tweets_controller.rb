class TweetsController < ApplicationController

    get '/tweets'  #read - if user is logged in, will take to '/tweets' , if not logged in, redirects to '/login'
    
    end
    
    get '/tweets/new' do  #read - form to create new tweet

    end

    post '/tweets'  #submits and saves tweet that was created

    end

    get '/tweets/:id' do #shows tweets

    end

    get '/tweets/:id/edit' do  #form to edit tweet 

    end

    post '/tweets/:id' do  #submits saved tweet and shows result

    end

    post '/tweets/:id/delete' do   #deletes tweet (on tweet show page, as a button)

    end
end
