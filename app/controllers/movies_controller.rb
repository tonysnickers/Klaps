class MoviesController < ApplicationController
  def index
    @movies = policy_scope(Movie)
    @genre_all, @keyword_all, @duration_all, @date_all, @actor_all = Array.new(5) { [] }

    # On itère sur chaque quiz, et dans chaque quiz sur chaque réponse
    # Les variables contiennent donc les réponses de tous les utilisateurs


    Group.find(params["group_id"]).quizz_choices.each do |q|

    #   #GENRE
    #   if q.genre.empty?
    #     @genre_all << ["Action", "Adventure", "Animation", "Comedy", "Crime", "Documentary", "Drama", "Fantasy", "Family",
    #                   "History", "Horror", "Music", "Mystery", "Romance", "Science Fiction", "Thriller", "TV Movie", "War",
    #                   "Western"]
    #   else
    #     q.genre.each do |g|
    #       @genre_all << g
    #     end
    #   end

    #   #KEYWORD
    #   @keyword_all << q.keyword  unless q.keyword.empty?

    #   (q.duration = 150) if q.duration.nil?
    #   @duration_all << q.duration

    #   q.start_year = 1980 if q.start_year.nil?
    #   @date_all << q.start_year
    #   q.end_year = 2022 if q.end_year.nil?
    #   @date_all << q.end_year

    #   if q.actor.empty?
    #     @actor_all << @actor_list
    #   else
    #     @actor_all << q.actor
    #   end
    # end

      @genre_all << q.genre
      @keyword_all << q.keyword
      @duration_all << q.duration
      @date_all << [q.start_year, q.end_year]
      @actor_all << q.actor


    end

    @movies_max = []

    Movie.all.each do |m|
      @genre_all.flatten.each do |g|
       @movies_max << m if m.genre.include?(g)
      end

      @keyword_all.flatten.each do |k|
        @movies_max << m if m.keyword.include?(k)
      end

      @duration_all.flatten.each do |d|
        @movies_max << m if m.duration <= d
      end

      @date_all.each do |date|
        @movies_max << m if (m.year >= date[0] && m.year <= date[1])
      end

      @actor_all.flatten.each do |a|
        @movies_max << m if m.actor.include?(a)
      end

    end

    # @quizz_choice.actor = params["q"]
    # @actor = params["q"] if @actor.nil?

    # big_movie = Movie.all
    # duration_average = @duration_all.sum / @duration_all.length.to_f
    # date_range = @date_all.minmax

    # movie_finder = big_movie.map do |m|
    #   m unless (@genre_all & m.genre).empty?
    #   m unless (@keyword_all & m.keyword).empty?
    #   m unless (@actor_all & m.actor).empty?
    #   m unless duration_average < m.duration
    #   m unless m.year < date_range[0] || m.year > date_range[1]
    # end

    # movie_popular = movie_finder.tally
    # @movies = movie_popular.max_by(5) { |key, value| value }.map { |a| a[0] }


    @movies = @movies_max.tally.max_by(5) { |key, value| value }.map { |a| a[0] }


  end

  # def new
  # end

  # def create
  # end

  # def edit
  # end
end
