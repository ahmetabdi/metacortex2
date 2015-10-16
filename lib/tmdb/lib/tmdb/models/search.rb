class Tmdb::Search < Tmdb::ApiResource

  def self.multi(query)
    build_collection(Tmdb::Requester.get("search/multi", query: CGI::escape(query))['results'], MultiRepresenter)
  end

  def self.find_by_imdb(id)
    build_single_resource(Tmdb::Requester.get("find/#{id}", external_source: 'imdb_id'), MovieRepresenter)
  end

end
