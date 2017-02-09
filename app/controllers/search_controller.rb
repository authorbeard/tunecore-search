class SearchController < ApplicationController
  self.per_form_csrf_tokens = true

  def home
  end

  def search

    respond_to do |format|
      format.html
      format.json {render json: params[:q]}
    end
  end


  private

  def search_params
    params.require(:q).permit(:query_string, :narrow_query, search_opts: [], includes: [], narrow_by: [])

  end


end
