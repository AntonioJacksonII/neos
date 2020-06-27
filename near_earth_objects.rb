require 'faraday'
require 'figaro'
require 'pry'
require 'json'
# Load ENV vars via Figaro
Figaro.application = Figaro::Application.new(environment: 'production', path: File.expand_path('../config/application.yml', __FILE__))
Figaro.load

class NearEarthObjects

  attr_reader :name, :diameter, :miss_distance

  def initialize(data)
    @name = data[:name]
    @diameter = data[:estimated_diameter][:feet][:estimated_diameter_max].to_i
    @miss_distance = data[:close_approach_data][0][:miss_distance][:miles].to_i
  end

  def self.parse_asteroids_data(date)
    conn = Faraday.new(
      url: 'https://api.nasa.gov',
      params: { start_date: date, api_key: ENV['nasa_api_key']}
    )
    asteroids_list_data = conn.get('/neo/rest/v1/feed')

    JSON.parse(asteroids_list_data.body, symbolize_names: true)[:near_earth_objects][:"#{date}"]
  end
end
