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
      @vehicle.update(params)
      params.delete("_method")
      @vehicle.update(params)
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