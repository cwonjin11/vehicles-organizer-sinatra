Do prioritize

1. what are migrations?
 => Migrations are what we write to make changes to our database.
 2. Explain when the schema changes. 
 => after rake db:migration 
 3. in tux, how we access objects through activerecord associations.
 => current_user.vehicles -- will return an array of vehicles that belongs to the current_user object. 
 4. Where is the .vehicles method defined?
 => model -> has_many, belongs_to
 
