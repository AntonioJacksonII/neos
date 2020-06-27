require_relative 'near_earth_objects'

puts "________________________________________________________________________________________________________________________________"
puts "Welcome to NEO. Here you will find information about how many meteors, asteroids, comets pass by the earth every day. \nEnter a date below to get a list of the objects that have passed by the earth on that day."
puts "Please enter a date in the following format YYYY-MM-DD."
print ">>"

date = gets.chomp

parsed = NearEarthObjects.parse_asteroids_data(date)
asteroids = parsed.map { |asteroid| NearEarthObjects.new(asteroid)}
total_number_of_asteroids = asteroids.count
largest_asteroid = asteroids.map{ |asteroid| asteroid.diameter}.max

@maximum_name_length = asteroids.map{ |asteroid| asteroid.name.length}.max
@maximum_diameter_length = "Diameter".length
@maximum_miss_distance_length = "Missed The Earth By:".length

header = "| #{"Name".ljust(@maximum_name_length)} | Diameter | Missed The Earth By: |"
divider = "+-#{"-"*(@maximum_name_length)}-+#{"-"*(@maximum_diameter_length + 2)}+#{"-"*(@maximum_miss_distance_length + 2)}+"

def format_row_data(row_data)
  row = []
  row << row_data.name.ljust(@maximum_name_length)
  row << row_data.diameter.to_s.concat(" ft").ljust(@maximum_diameter_length)
  row << row_data.miss_distance.to_s.concat(" miles").ljust(@maximum_miss_distance_length)
  row = row.join(' | ')
  puts "| #{row} |"
end

def create_rows(asteroid_data)
  asteroid_data.each { |asteroid| format_row_data(asteroid) }
end

formated_date = DateTime.parse(date).strftime("%A %b %d, %Y")
puts "______________________________________________________________________________"
puts "On #{formated_date}, there were #{total_number_of_asteroids} objects that almost collided with the earth."
puts "The largest of these was #{largest_asteroid} ft. in diameter."
puts "\nHere is a list of objects with details:"
puts divider
puts header
create_rows(asteroids)
puts divider
