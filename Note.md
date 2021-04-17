<seeds.rb file>

User.destroy_all
Vehicle.destroy_all

10.times do
    User.create(username: Faker::Superhero.name, email: Faker::Internet.email, password_digest: Faker::Beer.brand)
end


200.times do
    Vehicle.create(brand:Faker::Vehicle.make , style: Faker::Vehicle.car_type, color: Faker::Vehicle.color, year: Faker::Vehicle.year, vin_number: Faker::Vehicle.vin, user_id: rand(1..10), model:Faker::Vehicle.model, price: rand(11000.00..99900.00))
end


<note>
#model = all of the relationships are 
#crud methods live in controllers
#other then run, use "use"

<deleted code>
# [from config.ru]
# if ActiveRecord::Migrator.needs_migration?
#   raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
# end



css

  h2 {
    border-bottom: 2px solid #ccc;
    font-size: 24px;
    line-height: 36px;
    margin-bottom: 16px;
  }


error in html
<% if @errors %>
  <% @errors.each do |error| %>
    <p style="color: crimson;"><%= error %></p>
  <% end %>
<% end %>





  a.button {
    background-color: rgb(173, 198, 230);
    ; /* Green */
    border: none;
    color: white;
    padding: 15px 32px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
  }

  a.button1 {
    border-radius: 8px;
    background-color: rgb(173, 198, 230);
    border: none;
    color: rgb(6, 15, 134);
    padding: 10px 15px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
  }