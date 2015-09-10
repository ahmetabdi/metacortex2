namespace :tmdb do
  desc "Dumps TMDB Database (Long running task..)"
  task :dump => :environment do
    last_id = Tmdb::Movie.latest.id

    starting_id = 1#(Movie.last.tmdb_id || 1)

    (starting_id..last_id).each do |i|
      movie = Tmdb::Movie.find(i)
      if movie
        Movie.where(tmdb_id: movie.id).first_or_create do |new_movie|
          new_movie.tmdb_id = movie.id
          new_movie.title = movie.title
          new_movie.backdrop_path = movie.backdrop_path
          new_movie.overview = movie.overview
          new_movie.release_date = movie.release_date
          new_movie.poster_path = movie.poster_path
          new_movie.imdb_id = movie.imdb_id
          new_movie.runtime = movie.runtime
          new_movie.revenue = movie.revenue
          new_movie.status = movie.status
          new_movie.tagline = movie.tagline
        end
      end

    end
  end
end
