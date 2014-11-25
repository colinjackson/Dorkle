class SearchesController < ApplicationController
  def query
    @results = PgSearch.multisearch(params["query"])
      .includes("searchable").map(&:searchable)
    render :query
  end
end
