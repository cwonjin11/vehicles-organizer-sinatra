
class Vehicle < ActiveRecord::Base
    belongs_to :user
    validates :brand, :style, :color, :year, :model, :price, :vin_number, presence: true
    validates :vin_number, length: { is: 17 }
    validates :year, numericality: { only_integer: true }
    validates :price, format: { with: /\A\d+(?:\.\d{0,2})?\z/ }, numericality: { greater_than: 0, less_than: 1000000 }
   
end