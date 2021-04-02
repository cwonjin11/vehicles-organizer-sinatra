class VehicleController < ApplicationController

    get '/vehicles' do
        # binding.pry
        @vehicles = current_user.vehicles
        erb :'vehicles/index'
        
        
    end
end