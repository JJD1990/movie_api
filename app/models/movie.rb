require 'httparty'

class Movie < ApplicationRecord
  has_and_belongs_to_many :actors, through: :actors_movies
  include HTTParty
  base_uri 'https://www.omdbapi.com'

  def self.fetch_movie(movie_title)
    api_key = Rails.application.credentials[:movie_api_key]
    response = get("/?t=#{movie_title}&plot=full&apikey=#{api_key}")

    if response.success?
      data = response.parsed_response

      # Check if the movie already exists (by title)
      movie = Movie.find_by(title: data['Title'])

      if movie
        Rails.logger.info("[Movie.fetch_movie] Movie '#{movie.title}' already exists.")
      else
        # If it doesn't exist, create it
        movie = Movie.create(
          title: data['Title'],
          year: Date.parse("01-01-#{data["Year"]}"),
          rating: data['imdbRating'].to_f,
          runtime: data['Runtime'].to_i,
          director: data['Director']
        )
        Rails.logger.info("[Movie.fetch_movie] New movie '#{movie.title}' created.")
      end

      # Parse and associate actors
      actor_names = data['Actors'].split(",").map(&:strip)

      actor_names.each do |name|
        actor = Actor.find_or_create_by(name: name)

        # Add movie to actor's list if not already there
        unless actor.movies.exists?(movie.id)
          actor.movies << movie
          Rails.logger.info("[Movie.fetch_movie] Added movie '#{movie.title}' to actor '#{actor.name}'.")
        end
      end

      movie
    else
      Rails.logger.error("[Movie.fetch_movie] Failed request - code: #{response.code}")
      Rails.logger.error("[Movie.fetch_movie] Body: #{response.body}")
      { error: "Failed to fetch movie data. Status code: #{response.code}" }
    end
  rescue StandardError => e
    Rails.logger.fatal("[Movie.fetch_movie] Exception: #{e.class} - #{e.message}")
    { error: "An exception occurred while fetching movie data: #{e.message}" }
  end
end
