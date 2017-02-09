class SearchController < ApplicationController
  self.per_form_csrf_tokens = true

  def home
  end

  def search
byebug

  end


  private

  def search_params
    require(:q).permit(:query_string)

  end


end
