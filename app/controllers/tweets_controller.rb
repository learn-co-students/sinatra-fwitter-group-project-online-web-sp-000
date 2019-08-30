class TweetsController < ApplicationController

get '/tweets' do
  #binding.pry
  erb :'tweets/tweets'
end

end
