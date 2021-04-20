class User < ActiveRecord::Base
    has_many :vehicles

<<<<<<< HEAD
    has_secure_password  # need a macro to leverage the bcrypt gem
    #Add bcrypt (~> 3.1.7) to Gemfile to use has_secure_password:
    #loads instance method 'authenticate'
    #loads bcrypt gem to make the password salted and hased.
=======
    has_secure_password
>>>>>>> a4070289c27e6112637a0f58a8fe9ef63289c1c3


    validates_presence_of :username, :email
    validates_uniqueness_of :username, :email 



end