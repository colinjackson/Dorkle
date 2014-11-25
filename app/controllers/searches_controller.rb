class SearchesController < ApplicationController
  def query
    if params[:search]
      @query = params[:search][:query]
      @results = PgSearch.multisearch(@query)
        .includes("searchable").map(&:searchable)
    else
      @query = nil
      @results = []
    end

    render :query
  end
end
