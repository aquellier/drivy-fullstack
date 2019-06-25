require 'json'
require_relative 'models/car'
require_relative 'models/rental'

# Used as a DB to interact with json files
class Drivy
  def initialize(json_file)
    @json_file = json_file
    @cars = []
    @rentals = []
    parse_and_load_data if File.exist?(@json_file)
  end

  def save_to_json
    rentals_hash = {}
    rentals_hash[:rentals] = @rentals.map(&:rental_price_and_commission)
    File.open('data/output.json', 'w') do |f|
      f.write(JSON.pretty_generate(rentals_hash))
    end
  end

  private

  def parse_and_load_data
    parsed_json = JSON.parse(File.read(@json_file), symbolize_names: true)
    json_cars_to_instances(parsed_json[:cars])
    json_rentals_to_instances(@cars, parsed_json[:rentals])
  end

  def json_cars_to_instances(cars)
    cars.each do |car|
      @cars << Car.new(
        car[:id],
        car[:price_per_day],
        car[:price_per_km]
      )
    end
  end

  def json_rentals_to_instances(cars, rentals)
    rentals.each do |rental|
      @rentals << Rental.new(
        rental[:id],
        cars.find { |car| car.id == rental[:car_id] },
        rental[:start_date],
        rental[:end_date],
        rental[:distance]
      )
    end
  end
end
