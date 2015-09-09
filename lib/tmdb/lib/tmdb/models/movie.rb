class Tmdb::Movie < Tmdb::ApiResource

  def self.find(id)
    build_single_resource(Tmdb::Requester.get("movie/#{id}"), MovieRepresenter)
  end

  def self.popular
    build_collection(Tmdb::Requester.get("movie/popular")['results'], MovieRepresenter)
  end

  def self.latest
    build_single_resource(Tmdb::Requester.get("movie/latest"), MovieRepresenter)
  end

end
