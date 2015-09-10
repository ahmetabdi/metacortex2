class SearchController < ApplicationController
  def global_search
    results = Movie.search(params[:query], fields: [:title])
    render json: results
  end
end
