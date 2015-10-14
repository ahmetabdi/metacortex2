require 'benchmark'
require 'typhoeus'
require 'typhoeus/adapters/faraday'
require 'time'

namespace :movienight do
  desc 'Downloads all URLs from the frontpage of movienight'
  task fetch: :environment do
    Movie.destroy_all
    Link.destroy_all
    puts Benchmark.measure {
      pages = []
      links = []
      posts = []

      conn = Faraday.new(url: 'http://movienight.ws') do |faraday|
        faraday.adapter :typhoeus
      end

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

      conn.in_parallel do
        links.each do |link|
          posts << conn.get(link)
        end
      end

      posts.each do |post|
        article = Nokogiri::HTML(post.body)
        link = article.at_css('iframe')
        next if link.nil?
        name = article.at_css('h1').text.gsub(/\(\d{4}\)/, '').strip
        video_link = link['src']

        url = URI('http://www.omdbapi.com/')
        url.query = URI.encode_www_form(t: name, plot: 'full', r: 'json')

        json = JSON.parse(Typhoeus.get(url.to_s).body)

        if json['Response'] == 'True'
          movie = Movie.where(imdb_id: json['imdbID']).first_or_create do |m|
            m.title = json['Title']
            m.year = json['Year']
            m.rated = json['Rated']
            m.release_date = Time.parse(json['Released']) unless json['Released'] == 'N/A' || json['Released'] == nil
            m.runtime = json['Runtime'].gsub('min', '').strip unless json['Runtime'] == 'N/A' || json['Runtime'] == nil
            m.genres = json['Genre']
            m.director = json['Director']
            m.writer = json['Writer']
            m.actors = json['Actors']
            m.plot = json['Plot']
            m.language = json['Language']
            m.country = json['Country']
            m.awards = json['Awards']
            m.poster = json['Poster']
            m.metascore = json['Metascore']
            m.imdb_rating = json['imdbRating']
            m.imdb_votes = json['imdbVotes']
            m.imdb_id = json['imdbID']
          end
          Link.where(movie_id: movie.id, link: video_link).first_or_create do |l|
            l.link = video_link
            l.site = URI(video_link).host
            l.movie_id = movie.id
          end
        else
          puts "Failed to get response for: #{name}"
        end
      end
    }
  end
end
