<seeds.rb file>

User.destroy_all
Vehicle.destroy_all

10.times do
    User.create(username: Faker::Superhero.name, email: Faker::Internet.email, password_digest: Faker::Beer.brand)
end


200.times do
    Vehicle.create(brand:Faker::Vehicle.make , style: Faker::Vehicle.car_type, color: Faker::Vehicle.color, year: Faker::Vehicle.year, vin_number: Faker::Vehicle.vin, user_id: rand(1..10), model:Faker::Vehicle.model, price: rand(11000.00..99900.00))
end