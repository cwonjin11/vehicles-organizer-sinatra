class UsersController < ApplicationController

    get '/signup' do
        if !session[:user_id] 
            erb :'users/create_user'
        else
          redirect to('/vehicles')
        end
    end

    post '/signup' do
        user = User.new(params)
        if !user.save 
            @errors = user.errors.full_messages.to_sentence 
            erb :'users/create_user'
        else 
            session[:user_id] = user.id
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
      
    post '/login' do  
        user = User.find_by(username: params[:username]) 
          if user && user.authenticate(params[:password]) 

            session[:user_id] = user.id 
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
              redirect to('/')
          end
    end

end
