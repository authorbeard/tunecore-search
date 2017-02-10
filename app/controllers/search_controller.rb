class SearchController < ApplicationController
  self.per_form_csrf_tokens = true

  def home
    @artists = Artist.all
  end

  def search
  byebug
    search=SearchService.new
    search_results = search.send(search_params["search_opts"], search_params)
    respond_to do |format|
      format.html
      format.json {render json: search_results}
    end
  end


  private

  def search_params
    params.require(:q).permit(:query_string, :narrow_by, :narrow_query, :search_opts, :includes=>[])

  end


end
