# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'open-uri'
require 'json'

5.times do |i|
  url = "https://api.themoviedb.org/3/movie/top_rated?api_key=f17e77f26c10a22fe751fc273dbbac6a&language=en-US&page=#{i + 1}"
  movie_serialized = URI.open(url).read
  movies = JSON.parse(movie_serialized)

  movies['results'].each do |movie|
    Movie.create(
      title: movie['title'],
      overview: movie['overview'],
      poster_url: "https://image.tmdb.org/t/p/original#{movie['poster_path']}",
      rating: movie['vote_average']
    )
  end
end
