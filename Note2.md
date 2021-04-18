Do prioritize

1. what are migrations?
   => Migrations are what we write to make changes to our database.
   => Creating the database table
2. Explain when the schema changes.
   => after rake db:migration or roll-back
   => schema.rb; This file shows “current state of the database”
3. in tux, how we access objects through activerecord associations.
   => current_user.vehicles ; will return an array of vehicles that belongs to the current_user object.
4. Where is the .vehicles method defined?
   => model -> has_many, belongs_to

## MVC

At the end of this unit you should be able to explain the MVC flow in your own words.!
=> The MVC structure allows us to separate our application's concern, ultimately optimizing functionality and code organization.

1. Model => Database
   1. Logic, this is the one we have to have.
   2. interfaces in between active record and our database.
   3. allow us to get to our objects. inherit from ActiveRecord::Base, in charge of our objects
2. Contoroller => Intermediary for the Model and View
   1. it works in between the model and the views.
   2. accept web request from the view, sends them to the model,
   3. passes data to the view, hold all of our CRUD function.
3. View => The Frontend of our Application
   1. responsible for displaying data to our users and getting data from the user

### What is the difference between rendering vs. redirecting?

## rendering vs redirect

- Rendering
  allows us to pass instance variable through to the erb files
  displays the view without submitting an additional request to the server
- Redirecting
  Sends a new request to the server
  can’t pass instance variable because of the statelessness of the server
  instance variable no longer exists once a new request has been made => http is a stateless protocol

### Where do the instance variables in our view files come from — where are they declared and how do we have access to them?

=> declared in the controller and by using the instance variable, we can pass the instance variable through to the erb file without submitting an additional request to the server.

## rendering

    when you render somthing with erb, erb can show instance variables. redirecting can not!
    how ? set an instance variable in the controller and passes that instance variables to the view.

    redirecting actually refreshes the page and http is stateless we can not pass through an instance variables on a redirect
    when to redirect ? creating a new object or etc.

## HTTP is a stateless protocol

- State / stateful : remembered information
  => a system is described as stateful if it is designed to remember preceding events or user interactions; the remembered information is called the state of the system.
  => Each web request you send is, from the point of view of the application that is receiving that request, totally independent
## password / authentication

=> when user inputs password, that is just a word. It could be anything, any word.
But it is already salted and hashed in the back-end(database).
Since we submitted it as a string via params, we can see the plain text version of password right now.
But, it's going to get decrypted on the back-end and our bcrypt gem actually takes that plain text password and compares to the encrypted version in the back-end.
what .authenticate method do?
=> Does this plain text password acutally match up with the version we have in the back end?

### What is a session? How do I enable it in my application and why

<Sessions and Data Persistance>
The Hyper-Text Transfer Protocol (HTTP) is, by definition, a stateless protocol. What does "stateless" mean? HTTP is called a "stateless protocol" because a browser does not attach special meaning to a request, and consequently does not require the server to retain any information about a user or entity for the duration of a request.

For example, when you log in to http://www.learn.co (Links to an external site.), you fill out a form with your Github username and password. Learn receives that information and, at that moment in time, knows who you are by matching up that log in information, submitted via a HTTP POST request, with data in its database. What about after you log in? After you log in and click a link for a particular lesson, you are sending another HTTP request to Learn. At this point in the process of your interaction with the Learn web application, Learn has no idea who you are! But wait, you might be thinking: "Didn't I just log in? How can Learn forget so easily?" That is what it means to be "stateless". Each web request you send is, from the point of view of the application that is receiving that request, totally independent.

Then how, you might be wondering, does Learn (and every other web app) know who I am after I log in? Through the use of sessions.

A session is a hash that lives in your application in the server. The session hash can be accessed in any controller file of your application. Whatever data is stored in the session hash can thus be accessed, added to, changed or deleted in any controller file or route at any time and that change persists for the duration of the session.

When we say "duration of the session", we mean the period of time in which you, the client, are interacting with the web application. This is usually the time in between logging in and logging out.

In fact, the act of "logging in", is simply the the act of having your user id stored inside the session hash. The act of "logging out" is simply the act of your user id being removed from the session hash.

The session hash is most commonly used to store info like a user's id, which the web application will use to know who is the "current user" and show that user the appropriate information (for example, their profile page, their shopping cart, etc). However, we can put anything we want inside the session hash. //


Session
A session creates a file in a temporary directory on the server where registered session variables and their values are stored. This data will be available to all pages on the site during that visit.
A session ends when the user closes the browser or after leaving the site, the server will terminate the session after a predetermined period of time, commonly 30 minutes duration.

Session is basically just a hash that stores data on the server and passes that data to the client as a cookie.
Cookies are text files stored on the client computer and they are kept of use tracking purpose

## What are the basics of ActiveRecord's has_secure_password method?

- Adds methods to set and authenticate against a BCrypt password. This mechanism requires you to have a XXX_digest attribute. Where XXX is the attribute name of your desired password.

- The following validations are added automatically:
  Password must be present on creation
  Password length should be less than or equal to 72 bytes
  Confirmation of password (using a XXX_confirmation attribute)

## What does the .authenticate method do and how is it connected to the has_secure_password method
1. user input plain text password
2. bcrypt gem will make that password salted and hashed version
3. active record's has_secure_password code will call .authenticate method
4. .authenticate method will match up the ecnrypted password done by bcrypt gem with encrypted version of password saved in the database.
5. if these two password matches, authenticate will return the User instance. If not, it returns false.


- This ActiveRecord macro gives us access to a few new methods. A macro is a method that when called, creates methods for you. This is meta programming, which you don't need to worry about now. Just know that using a macro is just like calling a normal ruby method.
  In this case, the macro has_secure_password is being called just like a normal ruby method. It works in conjunction with a gem called bcrypt and gives us all of those abilities in a secure way that doesn't actually store the plain text password in the database.

- it match up the plain text password from the user input with the version we have in the back-end.
- .authenticate comes from active record's has_secure_password code.
- .authenticate matches the encrypted password between encrypted user input and encrypted password saved in the server.
- => Does this plain text password acutally match up with the version we have in the back end?

## Why do we use the bcrypt gem and what is the significance of adding the password_digest column to the User model in the database?

- bcrypt gem : It will store a salted, hashed version of our users' passwords in our database in a column called password_digest.
- it makes to save the salted and hashed password in the databse column called password_digest. However, we still access the attribute of password given by has_secure_password method.
- it also add "password" and  "password_confirmation" validations with 72 byes length limits automatically.
- In order to work with bcrypt gem, we need to use password_digest in the table column

## Rack Unit: How the Internet Works, Request/Response Flow, Routes

=> The browser(the client)is making a GET request (HTTP request) to the server.
=> The server then sends back a response and the client renders the page in the browser.

## Difference between get, post, patch, and delete requests and responses.

- get : hey server, please GET me this resource”
  Retrieves a representation of a resource
- post : send some data from the user to the server
  Submits data to be processed in the body of the request
- patch : Apply a partial modification of a resource
- delete : Deletes a specific resource

## How "Dynamic URL Routes" work.

=> Dynamic webapps are sites where the content changes based on user input (e.g. Facebook, Twitter, Yelp, etc.). Every time you visit the site, the content is most likely different because someone else gave a review of that restaurant, or sent out a new tweet, or commented on that image you liked.
Practice solidifying your understanding of the Request/Response Flow by drawing your own diagrams of this flow

extra notes

1. Tip: a flash[:message] has the lifecyle of one GET request and will not show up when rendering an erb file.
2. Tip: has_secure_password has a built in validation for the password_digest attribute!
3. By using bracket [] we can access to the hash. e.g ) params = > { a => 1} , params['a'] => "1"


## helper do examples
Helprs do

 *  def current_user
      @current_user ||= User.find_by(id: session[:user_id])
 *  end


    #returns a boolean
 *  def logged_in?
      #current_user will return nil or the entire user object (we want true/false)
      !!current_user
 *  end


 *  def authorized_to_edit?(post)
      post.user == current_user
 *  end


 * def redirect_if_not_logged_in
      if !logged_in?
        flash[:errors] = "Must be logged in to view this page!"
        redirect '/login'
      end
 *  end

end

# private method exmaple
  private

  def find_post
    @post = Post.find(params[:id])
  end