require 'json'
require_relative 'drivy'

json_file = File.expand_path('data/input.json', __dir__)
drivy = Drivy.new(json_file)
drivy.save_to_json
