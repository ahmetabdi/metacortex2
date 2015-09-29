class TwoAdapter < Adapter

  SITE_NAME = '2ddl.tv'

  def scan
    pages = ["http://2ddl.tv/category/movies/",
             "http://2ddl.tv/category/movies/page/2",
             "http://2ddl.tv/category/movies/page/3/",
             "http://2ddl.tv/category/movies/page/4/",
             "http://2ddl.tv/category/movies/page/5/"]

    pages.each do |page|

      doc = Nokogiri::HTML(Typhoeus.get(page).body)
      doc.css('div.posttitle > h2 > a').map {|p| p['href'] }.each do |link|
        post = Nokogiri::HTML(Typhoeus.get(link).body)

        release_name = post.at_css('div.posttitle > h2 > a').text
        content = post.css('.postarea').to_s

        links = all_links(content)
        imdb_id = imdb_id(content)

        if imdb_id
          movie = grab_tmdb_movie(imdb_id)

          if movie
            # Add movie if it doesn't exist
            tmdb_movie = add_movie(movie)
            # Add links if (first) link doesn't exist

            MovieRelease.create!(name: release_name, movie_id: tmdb_movie.id)
          end
        end

        # add_link(ul_to(links), 'ul.to', SITE_NAME, release_name, tmdb_movie)
        # add_link(nitro(links), 'nitroflare.com', SITE_NAME, release_name, tmdb_movie)
        # add_link(rapidgator(links), 'rapidgator.net', SITE_NAME, release_name, tmdb_movie)
        # add_link(zippyshare(links), 'zippyshare.com', SITE_NAME, release_name, tmdb_movie)
        # add_link(go4up(links), 'go4up.com', SITE_NAME, release_name, tmdb_movie)
        # add_link(sh(links), 'sh.st', SITE_NAME, release_name, tmdb_movie)
        # add_link(hugefiles(links), 'hugefiles.net', SITE_NAME, release_name, tmdb_movie)
        # add_link(filefactory(links), 'filefactory.com', SITE_NAME, release_name, tmdb_movie)
      end
    end
    # @feed.entries.each do |entry|
    #   links = all_links(entry.content)
    #   imdb_id = imdb_id(entry.content)
    #   movie = grab_tmdb_movie(imdb_id)
    #
    #   # Add movie if it doesn't exist
    #   tmdb_movie = add_movie(movie)
    #   # Add links if (first) link doesn't exist
    #   add_link(ul_to(links), 'ul.to', '2ddl.tv', tmdb_movie)
    #   add_link(nitro(links), 'nitroflare.com', '2ddl.tv', tmdb_movie)
    #   add_link(rapidgator(links), 'rapidgator.net', '2ddl.tv', tmdb_movie)
    #   add_link(zippyshare(links), 'zippyshare.com', '2ddl.tv', tmdb_movie)
    #   add_link(go4up(links), 'go4up.com', '2ddl.tv', tmdb_movie)
    #   add_link(sh(links), 'sh.st', '2ddl.tv', tmdb_movie)
    #   add_link(hugefiles(links), 'hugefiles.net', '2ddl.tv', tmdb_movie)
    #   add_link(filefactory(links), 'filefactory.com', '2ddl.tv', tmdb_movie)
    # end
  end

  def all_links(content)
    content.scan(%r{"([^"]*)"}).flatten
  end

end
