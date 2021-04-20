require './config/environment'
require 'active_support/core_ext/numeric/conversions' #Enables the formatting of numbers in a variety of ways.
require 'rack-flash'
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
<<<<<<< HEAD
    enable :sessions  #<= where we enable are session 
    set :session_secret, "secure_ur_cars" # set session secret for extra layer of security
    use Rack::Flash #to use flash message for undefined objects
=======
    enable :sessions 
    set :session_secret, "secure_ur_cars"
    use Rack::Flash 
>>>>>>> a4070289c27e6112637a0f58a8fe9ef63289c1c3
  end

  get "/" do
    if logged_in?
      redirect to('/vehicles')
    else
      erb :welcome
    end
  end


  helpers do 
    def logged_in? 
      !!session[:user_id]
<<<<<<< HEAD
      #returns true of false. In other words, is there a user_id in the session hash? true? or false?
      # @user ||= User.find_by(id: session[:user_id])
      #This method should return true if the user_id is in the session hash and false if not.
=======
>>>>>>> a4070289c27e6112637a0f58a8fe9ef63289c1c3
    end

    def current_user 
      @current_user = User.find(session[:user_id]) 
<<<<<<< HEAD
      #find if a user id which is equalt to user_id value in the session hash.
      # same as @current_user ||= User.find_by(id: session[user_id])
      
      #This method should use the user_id from the session hash to find the user in the database and return that user
=======
>>>>>>> a4070289c27e6112637a0f58a8fe9ef63289c1c3
    end

    def redirect_if_not_logged_in #=> else part is keep repeating so we can use this method to make it dry.
      if !logged_in?
        flash[:notice] = "test error messages."
        redirect to('/login')
      end
    end

    def authorized_to_edit?(vehicle) #=> in my app, need to pass @vehicle in the controller action since i used instance variable to find params id
      vehicle.user == current_user
    end

  end


end



