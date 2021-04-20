require './config/environment'


if ActiveRecord::Base.connection.migration_context.needs_migration?
    raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

# this is where we'll introduce middleware to override our methods for PATCH and DELETE requests
use Rack::MethodOverride #html can only do get and post. tell active record want to more than get and post. edit/update
    #  !!  PATCH-REQUESTS  !!
    #  HTML Limitations
    #  **  Do something other than GET + POST
run ApplicationController 
use UsersController #why do wee need this? 
use VehiclesController





