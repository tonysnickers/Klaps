require 'open-uri'
require 'json'

puts "Cleaning up database..."
Movie.destroy_all
puts "Database cleaned"

# for i in (570..575) do # TODO: pages de 1 à 500
  movies = JSON.parse(URI.open("https://api.themoviedb.org/3/movie/top_rated?api_key=5a07d55b0507c919cb598bae7c6fd7b4").read)["results"]
# p movies

  movies.each do |movie|
    base_poster_url = "https://image.tmdb.org/t/p/original"
    base_keyword_url = "https://api.themoviedb.org/3/movie/#{movie["id"]}/keywords?api_key=5a07d55b0507c919cb598bae7c6fd7b4"
    base_platform_url = "https://api.themoviedb.org/3/movie/#{movie["id"]}/watch/providers?api_key=5a07d55b0507c919cb598bae7c6fd7b4"
    base_movie_url = "https://api.themoviedb.org/3/movie/#{movie["id"]}?api_key=5a07d55b0507c919cb598bae7c6fd7b4"
    base_actor_url = "https://api.themoviedb.org/3/movie/#{movie["id"]}/credits?api_key=5a07d55b0507c919cb598bae7c6fd7b4"

    keywords = JSON.parse(URI.open(base_keyword_url).read)['keywords']
    platforms = JSON.parse(URI.open(base_platform_url).read)
    moviez = JSON.parse(URI.open(base_movie_url).read)
    actors = JSON.parse(URI.open(base_actor_url).read)

    if platforms['results']['FR'] && platforms['results']['FR']['flatrate']
      platform = platforms['results']['FR']['flatrate'][0]['provider_name']
    end

    if moviez['production_countries'] && moviez['production_countries'][0] && moviez['production_countries'][0]['name']
      country = moviez['production_countries'][0]['name']
    end

    if keywords.length > 0
      keyword = []
      keywords.each do |key|
        keyword << key['name']
      end
    end

    puts movie['title']

    Movie.create!(
      name: movie['title'],
      # idapi: movie['id'],
      duration: moviez['runtime'],
      rating: movie['vote_average'],
      year: movie['release_date'],
      country: country,
      keyword: keyword,
      poster: "#{base_poster_url}#{movie['poster_path']}",
      synopsis: movie['overview'],
      # genre: moviez['genres'][0]['name'],
      platform: platform,
      # actor: actors[cast].first(5)
    )
  end
# end

puts "Movies created"
puts Movie.all.last.keyword
puts Movie.all.last.platform
