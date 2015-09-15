class Adapter
  def initialize(feed_url)
    @feed_url = feed_url
  end

  def fetch
    result = Feedjira::Feed.fetch_and_parse(@feed_url)
    result.entries.last.content
  end

  # this.scan(%r{href=".+?(?=")})
  # grab all href urls
  def imdb_id(content)
    content.match(%r{tt\d{7}})[0]
  end

  def ul_to(content)
    content.match(%r{http://ul.to\/[a-zA-Z0-9]{8}})
  end

  # http://2ddl.tv/category/movies/feed
  # imdb_id = tt3824412
  def grab_tmdb_movie(imdb_id)
    Tmdb::Movie.find(imdb_id)
  end

  def scan_movies
    raise NotImplementedError
  end
end
