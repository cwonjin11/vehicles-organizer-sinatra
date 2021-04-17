class VehiclesController < ApplicationController

    get '/vehicles' do
        if logged_in?
            @vehicles = current_user.vehicles
            erb :'vehicles/index'
        else
            flash[:notice] = "Please log in or sign up to continue."
            redirect to('/login')
        end

    end

    get '/vehicles/new' do
      if logged_in?
        @vehicle = Vehicle.new(params)
        erb :'vehicles/new'
      else
        flash[:notice] = "Please log in or sign up to continue."
        redirect to('/login')
      end
    end

    post '/vehicles' do
      if logged_in?
        # binding.pry
        # @vehicle = Vehicle.new(brand: params["brand"], model: params["model"], year: params["year"],
        #   style: params["style"], color: params["color"], price: params["price"], vin_number: params["vin_number"], user_id: current_user.id)
          @vehicle = current_user.vehicles.build(params)
        if !@vehicle.save #you dont want to save always. Validation needed.
          @errors = @vehicle.errors.full_messages
          erb :'/vehicles/new'
        else
          flash[:notice] = "Vehicle successfully created!"
          redirect to("/vehicles/#{@vehicle.id}") #you may delete @ sign "#{@vehicle.id}"
          #in this case we need @ at line 33. why?
          #if you want to pass the instace to erb, we need instance variable. other than that, @ is not necessarily needed.
        end
      else
        flash[:notice] = "Please log in or sign up to continue."
        redirect to('/login')
      end
    end  
  
    get '/vehicles/:id' do 
      if logged_in? 
        @vehicle = Vehicle.find_by_id(params[:id])
          if @vehicle == nil
            flash[:notice] = "Oops,, something went wrong! Please use valid inputs"
            redirect to('/login')  
          elsif @vehicle.user == current_user 
            erb :'vehicles/show'
          else
            flash[:notice] = "Oops,, something went wrong! You can only see your vehicles."
            redirect to('/login')
          end
      else
        flash[:notice] = "Please log in or sign up to continue."
        redirect to('/login')
      end 
    end

    get '/vehicles/:id/edit' do
      if logged_in?
        @vehicle = Vehicle.find_by_id(params[:id])
          if @vehicle == nil
            flash[:notice] = "Oops,, something went wrong! Please use valid inputs"
            redirect to('/login') 
          elsif @vehicle.user == current_user
            erb :'vehicles/edit'
          else
            flash[:notice] = "Oops,, something went wrong! You can only edit your vehicles."
            redirect to('/vehicles')
          end
      else 
        flash[:notice] = "Please log in or sign up to continue."
        redirect to('/login')
      end
    end
  
  
    patch '/vehicles/:id' do
      @vehicle = Vehicle.find_by_id(params[:id])
      params.delete("_method")
      # http form only allows get and post actions. 
      #By deleting _method form params hash, (it will actually delete "_method"=>"patch" 
      #and make it as post action but still patching it because we are user rack::methodoverride.)
      @vehicle.update(params)

      # @vehicle.brand = params[:brand]
      # @vehicle.model = params[:model]
      # @vehicle.year = params[:year]
      # @vehicle.style = params[:style]
      # @vehicle.color = params[:color]
      # @vehicle.price = params[:price]
      # @vehicle.vin_number = params[:vin_number]
        if !@vehicle.update(params)
          @errors = @vehicle.errors.full_messages.to_sentence
          erb :'/vehicles/edit'
        else
          flash[:notice] = "Your vehicle has been successfully updated!"
          redirect to("/vehicles/#{@vehicle.id}")
        end
      
    end  


    delete '/vehicles/:id/delete' do
      @vehicle = Vehicle.find(params[:id])
        if logged_in? && @vehicle.user == current_user
          @vehicle.destroy
          flash[:notice] = "You have successfully deleted your vehicle [#{@vehicle.brand}, #{@vehicle.model}, #{@vehicle.year}]!"
          redirect to('/vehicles')
        else
          flash[:notice] = "Please log in or sign up to continue."
          redirect to('/login')
        end
    end


end