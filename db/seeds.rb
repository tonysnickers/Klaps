require 'open-uri'
require 'json'

puts "Cleaning up database..."
Movie.destroy_all
puts "Database cleaned"

url = "https://api.themoviedb.org/3/movie/555?api_key=5a07d55b0507c919cb598bae7c6fd7b4"
10.times do |i|
  movies = JSON.parse(URI.open("https://api.themoviedb.org/3/movie/#{i}?api_key=5a07d55b0507c919cb598bae7c6fd7b4").read)['results']
  movies.each do |movie|
    puts "Creating #{movie['title']}"
    base_poster_url = "https://image.tmdb.org/t/p/original"
    Movie.create(
      title: movie['title'],
      synopsis: movie['overview'],
      poster_url: "#{base_poster_url}#{movie['backdrop_path']}",
      rating: movie['vote_average']
    )
  end
end
puts "Movies created"
