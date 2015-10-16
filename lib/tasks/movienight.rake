require 'benchmark'
require 'typhoeus'
require 'typhoeus/adapters/faraday'
require 'time'

namespace :movienight do
  desc 'Downloads all URLs from the frontpage of movienight'
  task fetch: :environment do
    puts Benchmark.measure {
      pages = []
      links = []
      posts = []

      conn = Faraday.new(url: 'http://movienight.ws') do |faraday|
        faraday.adapter :typhoeus
      end

      puts 'Fetch pages'
      conn.in_parallel do
        pages << conn.get('/')
        pages << conn.get('/page/2/')
        pages << conn.get('/page/3/')
        pages << conn.get('/page/4/')
        pages << conn.get('/page/5/')
      end

      pages.each do |page|
        doc = Nokogiri::HTML(page.body)
        links << doc.css('.post_box > a').map { |link| URI(link['href']).path }
        links.flatten!
      end

      puts "Fetching #{links.count} links"
      conn.in_parallel do
        links.each do |link|
          posts << conn.get(link)
        end
      end

      posts.each do |post|
        article = Nokogiri::HTML(post.body)
        link = article.at_css('iframe')
        next if link.nil? # Return if it doesn't have an iframe link
        name = article.at_css('h1').text.gsub(/\(\d{4}\)/, '').strip
        video_link = link['src']

        movie = Tmdb::Movie.find(Tmdb::Search.multi(name).first.id)
        next if movie.nil? # skip if cannot find a tmdb movie
        new_movie = Movie.where(imdb_id: movie.imdb_id).first_or_create do |m|
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

        Link.where(movie_id: new_movie.id, link: video_link).first_or_create do |l|
          l.link = video_link
          l.site = URI(video_link).host
          l.movie_id = new_movie.id
        end
      end
    }
  end
end
