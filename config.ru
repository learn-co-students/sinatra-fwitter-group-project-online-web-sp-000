require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end
# if ActiveRecord::Base.connection.migration_context.needs_migration?
#   raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
# end

use Rack::MethodOverride
use TweetController
use UserController
run ApplicationController
use UsersController
