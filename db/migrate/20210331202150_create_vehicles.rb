class CreateVehicles < ActiveRecord::Migration[5.2]
  def change
    create_table :vehicles do |t|
      t.string :brand
      t.string :style
      t.string :color
      t.integer :year
      t.string :vin_number
      t.integer :user_id
    end
  end
end
