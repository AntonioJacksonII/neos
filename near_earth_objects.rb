require 'faraday'
require 'figaro'
require 'pry'
require 'json'
# Load ENV vars via Figaro
Figaro.application = Figaro::Application.new(environment: 'production', path: File.expand_path('../config/application.yml', __FILE__))
Figaro.load

class NearEarthObjects
  def self.find_neos_by_date(date)
    conn = Faraday.new(
      url: 'https://api.nasa.gov',
      params: { start_date: date, api_key: ENV['nasa_api_key']}
    )
    asteroids_list_data = conn.get('/neo/rest/v1/feed')

    @parsed_asteroids_data = JSON.parse(asteroids_list_data.body, symbolize_names: true)[:near_earth_objects][:"#{date}"]

    total_number_of_astroids = @parsed_asteroids_data.count

    {
      total_number_of_astroids: total_number_of_astroids
    }
  end

  def self.asteroid_list
    @parsed_asteroids_data.map do |asteroid|
      {
        name: asteroid[:name],
        diameter: "#{asteroid[:estimated_diameter][:feet][:estimated_diameter_max].to_i} ft",
        miss_distance: "#{asteroid[:close_approach_data][0][:miss_distance][:miles].to_i} miles"
      }
    end
  end

  def self.biggest_asteroid
    @parsed_asteroids_data.map do |astroid|
      astroid[:estimated_diameter][:feet][:estimated_diameter_max].to_i
    end.max { |a,b| a <=> b}
  end
end
