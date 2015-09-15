class TwoAdapter < Adapter

  def scan
    @feed.entries.each do |entry|
      links = all_links(entry.content)
      imdb_id = imdb_id(entry.content)
      movie = grab_tmdb_movie(imdb_id)

      add_movie(movie)
    end
  end

  def all_links(content)
    content.scan(%r{"([^"]*)"}).flatten
  end

end
