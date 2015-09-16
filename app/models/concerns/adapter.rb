class Adapter
  def initialize(feed_url)
    @feed_url = feed_url
    @feed = Feedjira::Feed.fetch_and_parse(feed_url)
  end

  def all_links(content)
    content.scan(%r{"([^"]*)"}).flatten
  end

  def ul_to(links)
    links.select {|link| link.include?("ul.to") }
  end

  # doesn't handle strings with escape quotes \""
  # t.scan(%r{"(.*?)"})

  # this.scan(%r{href=".+?(?=")})
  # grab all href urls
  def imdb_id(content)
    content.match(%r{tt\d{7}})[0]
  end

  # def ul_to(content)
  #   content.match(%r{http://ul.to\/[a-zA-Z0-9]{8}})
  # end

  # http://2ddl.tv/category/movies/feed
  # imdb_id = tt3824412
  def grab_tmdb_movie(imdb_id)
    Tmdb::Movie.find(imdb_id)
  end

  def add_movie(movie)
    # movie = Tmdb::Movie.find(movie.id)
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

  def add_link(links, link_type, site, movie)
    # If the first link in the array exists skip adding these links
    return if links.empty? || Link.where("'#{links.first}' = ANY (links)").present?
    Link.create!(links: links, link_type: link_type, site: site, movie_id: movie.id)
  end

  def scan_movies
    raise NotImplementedError
  end
end
