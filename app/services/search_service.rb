class SearchService


  def initialize
  end

  def default(params)
    query = params["query_string"]
    artists=Artist.search(query)
    albums=Album.search(query)
    songs=Song.search(query)
    return_hash = {
      "songs": songs, 
      "albums": albums,
      "artists": artists
    }
    return return_hash
  end

  def custom(params)
    if params["includes"]
      byebug
      table_names = get_table_names(params["includes"])
      return true
    else


    end

  end


  private

  def get_table_names(array)
    return array.map{|item|
      ActiveSupport::Inflector.classify(item).constantize
    }
  end

end