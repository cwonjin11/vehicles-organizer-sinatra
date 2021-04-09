class VehiclesController < ApplicationController

    get '/vehicles' do
        # binding.pry
        if logged_in?
            @vehicles = current_user.vehicles
            # binding.pry
            erb :'vehicles/index'
        else
            redirect to('/login')
        end

    end

    get '/vehicles/new' do
      if logged_in?
        @vehicle = Vehicle.new(params)
        erb :'vehicles/new'
      else
        redirect to('/login')
      end
    end

    post '/vehicles' do
      if logged_in?
        @vehicle = Vehicle.new(brand: params["brand"], model: params["model"], year: params["year"],
          style: params["style"], color: params["color"], price: params["price"], vin_number: params["vin_number"], user_id: current_user.id)
        
        if !@vehicle.save #you dont want to save always. Validation needed.
          @errors = @vehicle.errors.full_messages
          erb :'/vehicles/new'
        else
          redirect to("/vehicles/#{@vehicle.id}") #you may delete @ sign "#{@vehicle.id}"
          #in this case we need @ at line 33. why?
          #if you want to pass the instace to erb, we need instance variable. other than that, @ is not necessarily needed.
        end
      else
        redirect to('/login')
      end
    end  

    get '/vehicles/:id' do
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
      #@vehicle.update(params)

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