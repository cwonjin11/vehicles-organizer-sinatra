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
    if logged_in?
      redirect to('/vehicles')
    else
      erb :welcome
    end
  end


  helpers do
    def current_user
      @current_user = User.find(session[:user_id])
    end

    def logged_in?
      !!session[:user_id]
      
    end

  end


end
