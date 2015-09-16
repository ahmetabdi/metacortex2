class TwoAdapter < Adapter

  def scan
    @feed.entries.each do |entry|
      links = all_links(entry.content)
      imdb_id = imdb_id(entry.content)
      movie = grab_tmdb_movie(imdb_id)

      # Add movie if it doesn't exist
      tmdb_movie = add_movie(movie)
      # Add links if (first) link doesn't exist
      add_link(ul_to(links), 'ul.to', tmdb_movie)
    end
  end

  def all_links(content)
    content.scan(%r{"([^"]*)"}).flatten
  end

end
