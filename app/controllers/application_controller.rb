require './config/environment'
require 'active_support/core_ext/numeric/conversions' #Enables the formatting of numbers in a variety of ways.
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secure_ur_cars"
  end

  get "/" do
    # binding.pry
    if logged_in?
      redirect to('/vehicles')
    else

      erb :welcome
    end
  end


  helpers do
    def current_user
      @current_user = User.find(session[:user_id])
      # binding.pry
      #This method should use the user_id from the session hash to find the user in the database and return that user
    end

    def logged_in?
      !!session[:user_id]
      #This method should return true if the user_id is in the session hash and false if not.
    end
  end


end
  #def self.current_user(session)
  #     @user = User.find_by_id(session[:user_id])
  # end

  # def self.is_logged_in?(session)
  #     #This method should return true if the user_id is in the session hash and false if not.
  #     !!session[:user_id]
  # end


