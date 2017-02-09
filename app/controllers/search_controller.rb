class SearchController < ApplicationController
  self.per_form_csrf_tokens = true

  def home
  end

  def search
byebug
    render json: params[:q]
  end


  private

  def search_params
    params.require(:q).permit(:query_string, :narrow_query, search_opts: [], includes: [], narrow_by: [])

  end


end
