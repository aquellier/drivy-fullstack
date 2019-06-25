require 'json'
require_relative 'models/car'
require_relative 'models/rental'
require_relative 'models/option'

# Used as a DB to interact with json files
class Drivy
  def initialize(json_file)
    @json_file = json_file
    @cars = []
    @rentals = []
    @options = []
    parse_and_load_data if File.exist?(@json_file)
  end

  def save_to_json
    rentals_hash = {}
    rentals_hash[:rentals] = @rentals.map(&:rental_options_and_actions)
    File.open('data/output.json', 'w') do |f|
      f.write(JSON.pretty_generate(rentals_hash))
    end
  end

  private

  def parse_and_load_data
    parsed_json = JSON.parse(File.read(@json_file), symbolize_names: true)
    json_cars_to_instances(parsed_json[:cars])
    json_rentals_to_instances(@cars, parsed_json[:rentals])
    json_options_to_instances(@rentals, parsed_json[:options])
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

  def json_options_to_instances(rentals, options)
    options.each do |option|
      parent_rental = rentals.find { |rental| rental.id == option[:rental_id] }
      new_option = Option.new(option[:id], parent_rental, option[:type])
      @options << new_option
      parent_rental.options << new_option
    end
  end
end
