require './config/environment'
require 'active_support/core_ext/numeric/conversions' #Enables the formatting of numbers in a variety of ways.
require 'rack-flash'
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions 
    set :session_secret, "secure_ur_cars"
    use Rack::Flash #to use flash message for undefined objects
  end

  get "/" do
    if logged_in?
      redirect to('/vehicles')
    else
      erb :welcome
    end
  end


  helpers do #helper block tells sinatra that theses method should be available anywhere
    def logged_in? # "?" returns true or false   # check to see if a user is logged in
      !!session[:user_id]
      # @user ||= User.find_by(id: session[:user_id])
      #This method should return true if the user_id is in the session hash and false if not.
    end

    def current_user # method to keep track of logged in user
      @current_user = User.find(session[:user_id]) 
      # same as @current_user ||= User.find_by(id: session[user_id])
      #This method should use the user_id from the session hash to find the user in the database and return that user
    end
  end


end



