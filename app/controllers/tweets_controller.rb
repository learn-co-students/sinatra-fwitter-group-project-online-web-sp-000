class TweetsController < ApplicationController

  get '/tweets' do
    @user = current_user
    erb :'tweets/tweets'
  end

end
