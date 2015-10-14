class Movie < ActiveRecord::Base
  extend FriendlyId

  searchkick text_middle: [:title]
  friendly_id :title, use: :slugged

  scope :with_images, -> { where.not(poster: nil, poster: 'N/A') }
  scope :latest, -> { order('updated_at ASC') }
  has_many :links

  # state_machine :state, :initial => :generic do
  #
  #   event :popular do
  #     transition any => :popular
  #   end
  #
  #   event :now_playing do
  #     transition any => :now_playing
  #   end
  #
  #   event :upcoming do
  #     transition any => :upcoming
  #   end
  #
  #   event :top_rated do
  #     transition any => :top_rated
  #   end
  #
  #   event :generic do
  #     transition any => :generic
  #   end
  # end

  def self.with_links
    links.any?
  end

  # def poster(size = 'w92')
  #   "http://image.tmdb.org/t/p/#{size}#{poster_path}"
  # end
  #
  # def backdrop(size)
  #   "http://image.tmdb.org/t/p/#{size}#{backdrop_path}"
  # end
  #
  # def imdb_link
  #   "http://www.imdb.com/title/#{imdb_id}/"
  # end
  #
  # def release_date_year
  #   Date.parse(release_date).year
  # end

  def to_s
    title
  end

  def as_json(options = {})
    super(only: [:title, :release_date, :plot, :runtime,
                 :year, :poster, :slug])
  end

end
