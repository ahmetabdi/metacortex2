class Tmdb::Movie < Tmdb::ApiResource

  def self.popular
    build_collection(Tmdb::Requester.get("movie/popular")['results'], MovieRepresenter)
  end

end
