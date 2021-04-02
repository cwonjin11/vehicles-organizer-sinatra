require './config/environment'

# if ActiveRecord::Migrator.needs_migration?
#   raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
# end

run ApplicationController
use UserController
use VehicleController

#model = all of the relationships are 
#crud methods live in controllers

#other then run, use "use"

