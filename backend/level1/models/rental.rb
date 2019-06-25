require 'date'

# Rental model, belongs to car
class Rental
  attr_reader :id, :car, :start_date, :end_date, :distance

  def initialize(id, car, start_date, end_date, distance)
    @id = id
    @car = car
    @start_date = Date.strptime(start_date, '%Y-%m-%d')
    @end_date = Date.strptime(end_date, '%Y-%m-%d')
    @distance = distance
  end

  def rental_price
    rental_days = (@end_date - @start_date).to_i + 1
    rental_price = rental_days * @car.price_per_day +
                   @distance * @car.price_per_km
    { id: @id, price: rental_price }
  end
end
