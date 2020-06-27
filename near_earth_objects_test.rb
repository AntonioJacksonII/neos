require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative 'near_earth_objects'

class NearEarthObjectsTest < Minitest::Test
  def test_a_date_returns_a_list_of_asteroids
    parsed = NearEarthObjects.parse_asteroids_data('2019-03-30')
    asteroids = parsed.map { |asteroid| NearEarthObjects.new(asteroid)}
    assert_equal '(2019 GD4)', asteroids.first.name
  end
end
