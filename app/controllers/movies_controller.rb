class MoviesController < ApplicationController
  def index
    @group = Group.find(params["group_id"])
    @group.points_to_achieve = @group.group_users.count * 15
    @group.save

    @movies = policy_scope(Movie)
    @genre_all, @keyword_all, @duration_all, @date_all, @actor_all = Array.new(5) { [] }

    Group.find(params["group_id"]).quizz_choices.each do |q|
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

    @movies = @movies_max.tally.max_by(5) { |key, value| value }.map { |a| a[0] }

    # movie_popular = movie_finder.tally
    # @movies = movie_popular.max_by(6) { |_key, value| value }.map { |a| a[0] }.reject { |m| m.nil? }

    if (@group.points_to_achieve - @group.total_points) <= 1
      redirect_to results_group_path(@group)
    end
  end
end
