require './config/environment'


if ActiveRecord::Base.connection.migration_context.needs_migration?
    raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

<<<<<<< HEAD
# this is where we'll introduce middleware to override our methods for PATCH and DELETE requests
use Rack::MethodOverride #html can only do get and post. tell active record want to more than get and post. edit/update
    #  !!  PATCH-REQUESTS  !!
    #  HTML Limitations
    #  **  Do something other than GET + POST
run ApplicationController 
use UsersController #why do wee need this? 
=======

use Rack::MethodOverride 
run ApplicationController
use UsersController 
>>>>>>> a4070289c27e6112637a0f58a8fe9ef63289c1c3
use VehiclesController





