require 'open-uri'
require 'json'

puts "Cleaning up database..."
OrderedChoice.destroy_all
puts "OrderedChoice drop ok"
Movie.destroy_all
puts "movie drop ok"
QuizzChoice.destroy_all
puts "QuizzChoice drop ok"
GroupUser.destroy_all
puts "group user drop ok"
Group.destroy_all
puts "group drop ok"
User.destroy_all
puts "Database cleaned"

antoine = User.create!(
  username: "Antoine",
  email: "antoine.mendy@gmail.com",
  password: "moviefinder"
)
manoa = User.create!(
  username: "Manoa",
  email: "manoa.ras@gmail.com",
  password: "moviefinder"
)

jeanne = User.create!(
  username: "Jeanne",
  email: "jeanne.deleusse@gmail.com",
  password: "moviefinder"
)

jacques = User.create!(
  username: "J.A",
  email: "ja.dc@gmail.com",
  password: "moviefinder"
)

antoine.save!
manoa.save!
jeanne.save!
jacques.save!

p antoine

mf = Group.create!(
  user: antoine,
  name: "Movie Finder Team !"
)

jea = GroupUser.create!(
  user: jeanne,
  group: mf
)

ant = GroupUser.create!(
  user: antoine,
  group: mf
)

man = GroupUser.create!(
  user: manoa,
  group: mf
)

(1...2).each do |page_number|
  movies = JSON.parse(URI.open("https://api.themoviedb.org/3/movie/top_rated?api_key=5a07d55b0507c919cb598bae7c6fd7b4&page=#{page_number}").read)["results"]

  movies.each do |movie|
    base_poster_url = "https://image.tmdb.org/t/p/original"
    base_keyword_url = "https://api.themoviedb.org/3/movie/#{movie['id']}/keywords?api_key=5a07d55b0507c919cb598bae7c6fd7b4"
    base_platform_url = "https://api.themoviedb.org/3/movie/#{movie['id']}/watch/providers?api_key=5a07d55b0507c919cb598bae7c6fd7b4"
    base_movie_url = "https://api.themoviedb.org/3/movie/#{movie['id']}?api_key=5a07d55b0507c919cb598bae7c6fd7b4"
    base_actor_url = "https://api.themoviedb.org/3/movie/#{movie['id']}/credits?api_key=5a07d55b0507c919cb598bae7c6fd7b4"

    keywords = JSON.parse(URI.open(base_keyword_url).read)['keywords']
    platforms = JSON.parse(URI.open(base_platform_url).read)
    moviez = JSON.parse(URI.open(base_movie_url).read)
    actors = JSON.parse(URI.open(base_actor_url).read)

    # si il existe une plateforme pour voir le film,
    # alors on stocke dans l'array platform toutes les plateformes FR qui le diffusent
    if platforms['results']['FR'] && platforms['results']['FR']['flatrate']
      platform = []
      platforms['results']['FR']['flatrate'].each do |plat|
        platform << plat['provider_name']
      end
      # platform = [0]['provider_name']
    end

    # on stocke dans actor les 5 premiers noms du casting
    if actors['cast']
      actor = []
      actors['cast'].first(5).each do |cast|
        actor << cast['name']
      end
    end

    # si il y a un pays de production
    if moviez['production_countries'] && moviez['production_countries'][0] && moviez['production_countries'][0]['name']
      country = moviez['production_countries'][0]['name']
    end

    # si il y  a des keywords on les met tous dans l'array keyword
    if keywords.length.positive?
      keyword = []
      keywords.first(15).each do |key|
        keyword << key['name']
      end
    end

    # si il y  a des genres on les met tous dans l'array genre
    if moviez['genres']
      genre = []
      moviez['genres'].each do |gender|
        genre << gender['name']
      end
    end

    puts movie['title']

    Movie.create!(
      name: movie['title'],
      duration: moviez['runtime'],
      rating: movie['vote_average'],
      year: movie['release_date'],
      country: country,
      keyword: keyword,
      poster: "#{base_poster_url}#{movie['poster_path']}",
      synopsis: movie['overview'],
      genre: genre,
      platform: platform,
      actor: actor
    )
  end
end

puts "Movies created"
puts Movie.all.last.keyword
puts Movie.all.last.platform
