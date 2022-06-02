class MoviesController < ApplicationController
  include Searchable
  def index
    # d'abord on donne des valeurs aux genre, duration, date, actor à un utilisateur qui ne spécifie pas
    @genre = params["quizz_choice"]["genre"].reject(&:empty?)
    @keyword = params["quizz_choice"]["keyword"].reject(&:empty?)
    @duration = params["quizz_choice"]["duration"]
    @date = params["quizz_choice"]["date"]
    @quizz_choice.actor = params["q"]

    if @genre.nil?
      @genre = ["Action", "Adventure", "Animation", "Comedy", "Crime", "Documentary", "Drama", "Fantasy", "Family",
                "History", "Horror", "Music", "Mystery", "Romance", "Science Fiction", "Thriller", "TV Movie", "War",
                "Western"]
    end

    @duration = params["quizz_choice"]["duration"] if @duration.nil?
    @keyword = params["quizz_choice"]["keyword"] if @keyword.nil?
    @date = params["quizz_choice"]["date"] if @date.nil?
    @actor = params["q"] if @actor.nil?

    # je récupère l'ID du groupe d'un questionnaire
    @quizz_choice.group = group_id
    # je récupère tous les quizz de ce groupe
    group_id.quizz_choices = quizz_choices_all
    genre_all = []
    keyword_all = []
    duration_all = []
    date_all = []
    actor_all = []

    # ensuite il faut rassembler le quizz_choices de chaque membre du groupe
    quizz_choices_all.each do |quizz_choice|
      genre_all << quizz_choice.genre
      keyword_all << quizz_choice.keyword
      duration_all << quizz_choice.duration
      date_all << quizz_choice.date
      actor_all << quizz_choice.actor
    end

    big_movie = Movie.all
    duration_average = duration_all.sum / duration_all.length.to_f
    date_range = date_all.minmax

    movie_finder = big_movie.map do |m|
      m unless (genre_all & m.genre).empty?
      m unless (keyword_all & m.keyword).empty?
      m unless (actor_all & m.actor).empty?
      m unless duration_average < m.duration
      m unless m.date < date_range[0] || m.date > date_range[1]

      # date_all.each do |date|
      #   m.date.include?(date)
      # end
    end

    movie_popular = movie_finder.tally
    movie_popular.values


    # movie_popular.sort_by(movie.rating, asc)
    # movie_final = movie_popular.first(10)

  end

  def new
  end

  def create
  end

  def edit
  end
end
