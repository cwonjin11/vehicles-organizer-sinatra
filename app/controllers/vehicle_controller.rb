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

    get '/vehicles/new' do
      if logged_in?
        erb :'vehicles/new'
      else
        redirect to('/login')
      end
    end

    post '/vehicles' do
      if logged_in?
        # binding.pry
        @vehicle = Vehicle.new(brand: params["brand"], model: params["model"], year: params["year"],
          style: params["style"], color: params["color"], price: params["price"], vin_number: params["vin_number"], user_id: current_user.id)
        # binding.pry
        
        if !@vehicle.save
          @errors = @vehicle.errors.full_messages
          erb :'/vehicles/new'
        else
          redirect to("/vehicles/#{@vehicle.id}") 
        end
      else
        redirect to('/login')
      end
    end  

    get '/vehicles/:id' do
      # binding.pry
      @vehicle = Vehicle.find(params[:id])
        if logged_in? && @vehicle.user == current_user
          erb :'vehicles/show'
        else
          redirect to('/login')
        end 
    end
    

    get '/vehicles/:id/edit' do
      @vehicle = Vehicle.find(params[:id])
        if logged_in? && @vehicle.user == current_user
          @vehicle = Vehicle.find(params[:id])
          @user = User.find(session[:user_id])
          erb :'vehicles/edit'
        else
          redirect to('/login')
        end
        # binding.pry
    end
  
  
    patch '/vehicles/:id' do
      @vehicle = Vehicle.find(params[:id])
     
      @vehicle.brand = params[:brand]
      @vehicle.model = params[:model]
      @vehicle.year = params[:year]
      @vehicle.style = params[:style]
      @vehicle.color = params[:color]
      @vehicle.price = params[:price]
      @vehicle.vin_number = params[:vin_number]
      # @vehicles = Vehicle.all
        if !@vehicle.save
          @errors = @vehicle.errors.full_messages
          erb :'/vehicles/edit'
        else
          redirect to("/vehicles/#{@vehicle.id}")
        end
    end  


    delete '/vehicles/:id/delete' do
      @vehicle = Vehicle.find(params[:id])
        if logged_in? && @vehicle.user == current_user
          @vehicle.destroy
          redirect to('/vehicles')
        else
          redirect to('/login')
        end
    end


end