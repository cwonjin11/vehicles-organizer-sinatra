require './config/environment'


if ActiveRecord::Base.connection.migration_context.needs_migration?
    raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
  end

use Rack::MethodOverride #html can do get and post. tell active record want to more than get and post. edit/update
run ApplicationController
use UsersController
use VehiclesController



