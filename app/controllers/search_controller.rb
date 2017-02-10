class SearchController < ApplicationController
  self.per_form_csrf_tokens = true

  def home
    @artists = Artist.all
  end

  def search
    redirect_to home_path, status: 400 and return if search_params.empty?
    search=SearchService.new
    search_results = search.send(search_params["search_opts"], search_params)
    render json: search_results
  end


  private

  def search_params
    params.require(:q).permit(:query_string, :narrow_by, :narrow_query, :search_opts, :includes=>[])
  end



end
