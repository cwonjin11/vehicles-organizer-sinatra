class User < ActiveRecord::Base
    has_many :vehicles

    has_secure_password
    #Add bcrypt (~> 3.1.7) to Gemfile to use has_secure_password:
    #loads instance method 'authenticate'
    #loads bcrypt gem to make the password salted and hased.


    validates_presence_of :username, :email #, :password => password is required with bcrypt gem as well already.
    validates_uniqueness_of :username, :email 



end