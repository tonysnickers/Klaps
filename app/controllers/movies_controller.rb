class MoviesController < ApplicationController
  def index
    raise
    @genre, @keyword, @duration, @date, @actor = Array.new(5) { [] }

    # On itères
    Group.find(params["group_id"]).quizz_choices.each do |m|
      m.genre.each do |g|
        if g.nil?
          g = ["Action", "Adventure", "Animation", "Comedy", "Crime", "Documentary", "Drama", "Fantasy", "Family",
                "History", "Horror", "Music", "Mystery", "Romance", "Science Fiction", "Thriller", "TV Movie", "War",
                "Western"]
        end
      @genre << g
      end
      m.keyword.each do |k|
        (@keyword << @keywords_list) if k.empty?
        @keyword << k
      end
      m.duration.each do |d|
        (d = 150) if d.nil?
        @duration << d
      end
      m.date.each do |d|
        (d = [1980, 2022]) if d.nil?
        @date << d
      end
      m.actor.each do |a|
        (@actor << @actor_list) if a.empty?
        @actor << a
      end
    end

    # @quizz_choice.actor = params["q"]
    # @actor = params["q"] if @actor.nil?




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
    end

    movie_popular = movie_finder.tally
    @movies = movie_popular.max_by(5) { |key, value| value }.map { |a| a[0] }
  end

  # def new
  # end

  # def create
  # end

  # def edit
  # end
end
