namespace :tmdb do
  desc 'Dumps TMDB Database (Long running task..)'
  task dump: :environment do
    last_id = Tmdb::Movie.latest.id

    starting_id = Movie.last.tmdb_id

    (starting_id..last_id).each do |i|
      movie = Tmdb::Movie.find(i)
      add_movie(movie) if movie
    end
  end

  desc 'Updates popular, upcoming, now playing and top rated movies'
  task update: :environment do
    Movie.with_states(:popular, :now_playing, :upcoming, :top_rated).map(&:generic!)

    Tmdb::Movie.popular.each do |movie|
      movie = add_movie(movie)
      movie.popular
    end
    Tmdb::Movie.now_playing.each do |movie|
      movie = add_movie(movie)
      movie.now_playing
    end
    Tmdb::Movie.upcoming.each do |movie|
      movie = add_movie(movie)
      movie.upcoming
    end
    Tmdb::Movie.top_rated.each do |movie|
      movie = add_movie(movie)
      movie.top_rated
    end
  end

  desc 'Runs the elastic search reindexer for search kick'
  task reindex: :environment do
    Movie.reindex
  end

  # desc "Scans movies from 2ddl"
  # task :twoddl => :environment do
  #   adapter = TwoAdapter.new
  #   adapter.scan
  # end

  # desc "Hi"
  # task :test => :environment do
  #   #1ca40c6e8c2ea9b1dad7fd44de022e41
  #   Alluc.new("Inside Out 2015 720p HDRip x264 AC3-FUN")
  #
  #   #page = "www.alluc.com/embed/id%3Aogikhxe9?alt=Tomorrowland.2015.BDRip.x264-SPARKS.mp4"
  #   #doc = Nokogiri::HTML(Typhoeus.get(page).body)
  #
  #   #vid = Nokogiri::HTML(Typhoeus.get(doc.at_css('iframe')['src']).body)
  #   #vids = vid.to_s.scan(%r{"([^"]*)"}).flatten
  #   #puts vids.select {|link| link.include?("mp4") }
  # end

  def add_movie(movie)
    movie = Tmdb::Movie.find(movie.id)
    Movie.where(tmdb_id: movie.id).first_or_create do |m|
      m.tmdb_id = movie.id
      m.title = movie.title
      m.backdrop_path = movie.backdrop_path
      m.overview = movie.overview
      m.release_date = movie.release_date
      m.poster_path = movie.poster_path
      m.imdb_id = movie.imdb_id
      m.runtime = movie.runtime
      m.revenue = movie.revenue
      m.status = movie.status
      m.tagline = movie.tagline
    end
  end
end
