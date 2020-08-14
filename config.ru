require './config/environment'



use Rack::MethodOverride
use TweetsController
use UsersController
run ApplicationController
