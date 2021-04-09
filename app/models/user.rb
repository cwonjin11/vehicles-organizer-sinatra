class User < ActiveRecord::Base
    has_many :vehicles

    has_secure_password
    #loads instance method 'authenticate'
    #loads bcrypt gem to make the password salted and hased.


    validates_presence_of :username, :email, :password
    validates_uniqueness_of :username, :email 



end