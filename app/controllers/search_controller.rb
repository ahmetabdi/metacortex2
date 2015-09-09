class SearchController < ApplicationController
  def global_search
    results = Tmdb::Search.multi(params[:query])
    render json: results
  end
end
