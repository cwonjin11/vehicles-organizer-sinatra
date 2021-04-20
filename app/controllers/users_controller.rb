class UsersController < ApplicationController

    # get sign up route to render form
    get '/signup' do
        if !session[:user_id] 
            erb :'users/create_user'
        else
          redirect to('/vehicles')
        end
    end
 
    #create new user using sign up form
    post '/signup' do
        user = User.new(params)
        if !user.save 
            @errors = user.errors.full_messages.to_sentence 
            erb :'users/create_user'
<<<<<<< HEAD
        else #if the user saved, that means user has all valid attributes
            #set the session id as user id
            # post sign up route to create user using params and add key/value pair to sessions hash
            session[:user_id] = user.id #where user actually log in.
            # and redirect the user
=======
        else 
            session[:user_id] = user.id
>>>>>>> a4070289c27e6112637a0f58a8fe9ef63289c1c3
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
      
<<<<<<< HEAD
    # important!!!   
    # Tip: Here is where we authenticate the user and leverage the session hash to log them in!
=======
>>>>>>> a4070289c27e6112637a0f58a8fe9ef63289c1c3
    post '/login' do  
        user = User.find_by(username: params[:username]) 
          if user && user.authenticate(params[:password]) 

<<<<<<< HEAD
            #put the user in the session ==> we are actually going to log our user in, which means we are going to append that user id to the session hash
            # Add a key/value pair to their sessions hash - THIS ACTUALLY LOGS THE USER IN
            session[:user_id] = user.id #we added user_id key-value pairs in session hash. session[:user_id] means add user_id in to the session hash
            #this is where and when user actually log in to !!
=======
            session[:user_id] = user.id 
>>>>>>> a4070289c27e6112637a0f58a8fe9ef63289c1c3
            redirect to('/vehicles')
          else
            @errors = "Please check your username and password."
            erb :'users/login'
          end
    end
      
      
    get '/logout' do
          if logged_in?
              session.clear 
              flash[:notice] = "You are logged out!"
              redirect to('/')
          else
            #redirect to home/landing page
              redirect to('/')
          end
    end

end
