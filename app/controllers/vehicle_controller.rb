class VehicleController < ApplicationController

    get '/vehicles' do
        # binding.pry
        if logged_in?
            @vehicles = current_user.vehicles
            erb :'vehicles/index'
        else
            redirect to('/login')
        end
            
    end

    get '/vehicles/:id' do
      @vehicle = Vehicle.find(params[:id])
        if logged_in? && @vehicle.user_id == current_user.id
          erb :'vehicles/show'
        else
          redirect to('/login')
        end 
    end

end