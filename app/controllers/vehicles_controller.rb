class VehiclesController < ApplicationController

    get '/vehicles' do
        if logged_in?
            @vehicles = current_user.vehicles
            # binding.pry
            erb :'vehicles/index'
        else
          redirect_if_not_logged_in
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

     # post route to send our params to and create new post (or resource)
    post '/vehicles' do
      # recieves the params from the form
      # using the params i will create the vehicle
      if logged_in?
          @vehicle = current_user.vehicles.build(params)
        if !@vehicle.save 
          @errors = @vehicle.errors.full_messages
          erb :'/vehicles/new'
        else
          flash[:notice] = "Vehicle successfully created!"
          redirect to("/vehicles/#{@vehicle.id}") 
        end
      else
        flash[:notice] = "Please log in or sign up to continue."
        redirect to('/login')
      end
    end  
  
    get '/vehicles/:id' do  # this is a dynamic route
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


 # UPDATE
    # implement Sinatra middleware 'MethodOverride' to intercept every request sent and override to perscribed method using a hidden input in our forms
      # for PATCH and DELETE
    # get route to "/posts/:id/edit" to render edit form
      # we need to add a hidden input to point to our patch route
    #patch route to "/posts/:id" to do .update on a post instance

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
  
  # patch route to update a existing post
    patch '/vehicles/:id' do
      # binding.pry
      @vehicle = Vehicle.find_by_id(params[:id])
<<<<<<< HEAD
      params.delete("_method")  
      # http form only allows get and post actions. 
      #By deleting _method form params hash, (it will actually delete "_method"=>"patch" 
      #and make it as post action but still patching it because we are user rack::methodoverride.)
      @vehicle.update(params)
      # @vehicle.update(brand: params[:brand], model: params[:model], year: params[:year], style: params[:style], color: params[:color], price: params[:price], vin_number: params[:vin_number])
      # @vehicle.brand = params[:brand]
      # @vehicle.model = params[:model]
      # @vehicle.year = params[:year]
      # @vehicle.style = params[:style]
      # @vehicle.color = params[:color]
      # @vehicle.price = params[:price]
      # @vehicle.vin_number = params[:vin_number]
=======
      params.delete("_method")
      @vehicle.update(params)
>>>>>>> a4070289c27e6112637a0f58a8fe9ef63289c1c3
        if !@vehicle.update(params)
          @errors = @vehicle.errors.full_messages.to_sentence
          erb :'/vehicles/edit'
        else
          flash[:notice] = "Your vehicle has been successfully updated!"
          redirect to("/vehicles/#{@vehicle.id}")
        end
      
    end  


    # render delete form on show page
    # we need to add a hidden input to point to our delete route
    # delete route to .destroy a post instance
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