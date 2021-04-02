class VehicleController < ApplicationController

    get '/vehicles' do
        erb :'vehicles/index'

    end
end