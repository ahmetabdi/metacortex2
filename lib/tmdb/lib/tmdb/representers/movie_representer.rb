module MovieRepresenter
  include Representable::JSON

  property :adult
  property :backdrop_path
  property :genre_ids
  property :id
  property :original_language
  property :original_title
  property :overview
  property :release_date
  property :poster_path
  property :popularity
  property :title
  property :video
  property :vote_average
  property :vote_count

end
