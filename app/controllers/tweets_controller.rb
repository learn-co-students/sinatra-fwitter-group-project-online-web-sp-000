class TweetsController < ApplicationController

    get '/tweets' do
        erb :'tweets/tweets'
    end

end
