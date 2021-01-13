class TweetsController < ApplicationController

    get '/tweets' do
        @session = session
        erb :'tweets/index'
    end

end
