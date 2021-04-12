class UsersController < ApplicationController

    get '/signup' do
        if !session[:user_id]
            erb :'users/create_user'
        else
          redirect to('/vehicles')
        end
    end

    post '/signup' do
        #create a new user
        @user = User.new(username: params["username"], email: params["email"], password: params["password"])
        #save the user
        if !@user.save #if the user is not saved
            @errors = @user.errors.full_messages #show error messages by using instance variable
            #redirect to the signup again
            erb :'users/create_user'
        else #if the user saved
            #set the session id
            session[:user_id] = @user.id
            #redirect the user
            redirect to('/vehicles')
        end
    end
    
    
    get '/login' do
        if !session[:user_id]
            erb :'users/login'
        else
            redirect to('/vehicles')
            
        end
    end
      
    # important!!!   
    post '/login' do
        #find the user by username
        user = User.find_by(username: params[:username])
        #check to see if the user exists? and the the password matches
          if user && user.authenticate(params[:password]) #.authenticate comes from bcrypt gem!!!
            
            #put the user in the session
            session[:user_id] = user.id #we added user_id key value in session hash
            #this is when user actually log in to !!

            #redirect them somwhere
            redirect to('/vehicles')
          else
            #if they dont, redirect them to somewhere
            # binding.pry
            @errors = "Please check your username and/or password."
            erb :'users/login'
          end
    end
      
      
    get '/logout' do
          if logged_in?
              session.clear #grap our session out and clear it!
              redirect to('/')
          else
              redirect to('/')
          end
    end

end
