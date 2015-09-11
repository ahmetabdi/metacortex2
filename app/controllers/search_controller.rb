class SearchController < ApplicationController
  def global_search
    results = Movie.search(params[:query], fields: [{title: :text_middle}], limit: 5)
    render json: results.as_json
  end
end
