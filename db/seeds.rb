# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'json'

puts 'Cleaning the movie database....'
Movie.destroy_all
puts 'Movie database is clean...'
puts 'Creating movies...'

url = "http://tmdb.lewagon.com/movie/top_rated"
# retrieve the JSON hash
movies = JSON.parse(open(url).read)["results"]
# 10.times do
movies.each do |movie|
  db_movie = Movie.create!(
    title: movie['original_title'],
    overview: movie['overview'],
    poster_url: "https://image.tmdb.org/t/p/w500/#{movie['poster_path']}",
    rating: movie['vote_average']
  )
  puts "Movie #{db_movie.id} is created..."
end
puts 'All done!'
