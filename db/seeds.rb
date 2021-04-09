User.destroy_all
Vehicle.destroy_all

10.times do
    User.create
    (
        username: Faker::Internet.username, 
        email: Faker::Internet.email, 
        password: "password"
    )
end


200.times do
    Vehicle.create
    (
        brand:Faker::Vehicle.make , 
        style: Faker::Vehicle.car_type, 
        color: Faker::Vehicle.color, 
        year: Faker::Vehicle.year, 
        vin_number: Faker::Vehicle.vin, 
        model:Faker::Vehicle.model, 
        price: rand(11000.00..99900.00), 
        user: User.all.sample
    )
end

puts "nuclear launch detected"