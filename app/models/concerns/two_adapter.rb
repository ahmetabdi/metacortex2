class TwoAdapter < Adapter

  def scan
    @feed.entries.each do |entry|
      links = all_links(entry.content)
      imdb_id = imdb_id(entry.content)
      movie = grab_tmdb_movie(imdb_id)

      # Add movie if it doesn't exist
      tmdb_movie = add_movie(movie)
      # Add links if (first) link doesn't exist
      add_link(ul_to(links), 'ul.to', '2ddl.tv', tmdb_movie)
      add_link(nitro(links), 'nitroflare.com', '2ddl.tv', tmdb_movie)
      add_link(rapidgator(links), 'rapidgator.net', '2ddl.tv', tmdb_movie)
      add_link(zippyshare(links), 'zippyshare.com', '2ddl.tv', tmdb_movie)
      add_link(go4up(links), 'go4up.com', '2ddl.tv', tmdb_movie)
      add_link(sh(links), 'sh.st', '2ddl.tv', tmdb_movie)
      add_link(hugefiles(links), 'hugefiles.net', '2ddl.tv', tmdb_movie)
      add_link(filefactory(links), 'filefactory.com', '2ddl.tv', tmdb_movie)
    end
  end

  def all_links(content)
    content.scan(%r{"([^"]*)"}).flatten
  end

end
