
class Vehicle < ActiveRecord::Base
    belongs_to :user
    validates :brand, :style, :color, :year, :vin_number, :model, :price, presence: true
end