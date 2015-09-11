class SearchController < ApplicationController
  def global_search
    results = Movie.search(params[:query], fields: [{title: :text_start}], limit: 5)
    render json: results.as_json(:only => [:title, :release_date, :overview, :runtime, :revenue, :poster_path])
  end
end
