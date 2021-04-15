class UsersController < ApplicationController

    get '/signup' do
        if !session[:user_id] #if session hash does not have a user_id  in the hash, return false.
            erb :'users/create_user'
        else
          redirect to('/vehicles')
        end
    end

    post '/signup' do
        #create a new user
        user = User.new(params)
        # user = User.new(username: params["username"], email: params["email"], password: params["password"])
        #save the user
        if !user.save 
           #if the user is not saved
            @errors = user.errors.full_messages.to_sentence #show error messages by using instance variable
            # and redirect to the signup again
            erb :'users/create_user'
        else #if the user saved, that means user has all valid attributes
            #set the session id as user id
            session[:user_id] = user.id #where user actually log in.
            # and redirect the user
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
    # Tip: Here is where we authenticate the user and leverage the session hash to log them in!
    post '/login' do  
        #find the user by username
        user = User.find_by(username: params[:username])
        #check to see if the user exists && the the password matches
          if user && user.authenticate(params[:password]) #we are calling .authenticate method from bcrypt gem!!!
             #.authenticate will actually decrypt the password.

            #put the user in the session ==> we are actually going to log our user in, which means we are going to append that user id to the session hash
            session[:user_id] = user.id #we added user_id key value in session hash. session[:user_id] means add user_id in to the session hash
            #this is when user actually log in to !!
           
            redirect to('/vehicles') #redirect them somwhere
          else
            #if they dont, redirect them to somewhere
            @errors = "Please check your username and password."
            erb :'users/login'
          end
    end
      
      
    get '/logout' do
          if logged_in?
              session.clear #grap our session out and clear it!
              flash[:notice] = "You are logged out!"
              redirect to('/')
             
          else
              redirect to('/')
          end
    end

end
