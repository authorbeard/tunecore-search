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

end