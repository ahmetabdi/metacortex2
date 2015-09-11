class Movie < ActiveRecord::Base
  searchkick text_start: [:title]

  scope :with_images, -> { where.not(poster_path: nil, backdrop_path: nil) }

  state_machine :state, :initial => :generic do

    event :popular do
      transition any => :popular
    end

    event :now_playing do
      transition any => :now_playing
    end

    event :upcoming do
      transition any => :upcoming
    end

    event :top_rated do
      transition any => :top_rated
    end

    event :generic do
      transition any => :generic
    end

  end

  def poster(size = 'w92')
    "http://image.tmdb.org/t/p/#{size}#{poster_path}"
  end

  def backdrop(size)
    "http://image.tmdb.org/t/p/#{size}#{backdrop_path}"
  end

  def imdb_link
    "http://www.imdb.com/title/#{imdb_id}/"
  end
end
