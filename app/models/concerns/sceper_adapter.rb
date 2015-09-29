class SceperAdapter < Adapter
  SITE_NAME = 'sceper.ws'
  # http://sceper.ws/category/movies

  def scan
    pages = [
      "http://sceper.ws/category/movies"#,
      # "http://sceper.ws/category/movies/page/2",
      # "http://sceper.ws/category/movies/page/3",
      # "http://sceper.ws/category/movies/page/4",
      # "http://sceper.ws/category/movies/page/5"
    ]

    pages.each do |page|
      doc = Nokogiri::HTML(Typhoeus.get(page).body)
      (1..9).each do |i|
        link = doc.at_css("#recent-posts > div:nth-child(#{i}) > h2 > a")
        next unless link.present?

        post = Nokogiri::HTML(Typhoeus.get(link['href']).body)

        release_name = post.at_css('#recent-posts > div.entry.post.clearfix > h1')
        content = post.at_css('#recent-posts > div.entry.post.clearfix').to_s

        links = all_links(content)

        puts links
      end
    end
  end

  def all_links(content)
    content.scan(%r{"([^"]*)"}).flatten
  end

end
