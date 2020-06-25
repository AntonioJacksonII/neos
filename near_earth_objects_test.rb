require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative 'near_earth_objects'

class NearEarthObjectsTest < Minitest::Test
  def test_a_date_returns_a_list_of_neos
    assert_equal '(2019 GD4)', NearEarthObjects.asteroid_list('2019-03-30')[0][:name]
  end
end
