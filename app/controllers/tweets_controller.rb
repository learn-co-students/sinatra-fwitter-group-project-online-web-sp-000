class TweetsController < ApplicationController

get '/' do
  erb :'tweets/index'
end

end
