class SearchService


  def initialize
  end

  def default(params)
    query = params["query_string"]
    songs_from_artists = Artist.song_ids(query)
    songs_from_albums = Album.song_ids(query)
    songs=Song.search(query) << Song.find(songs_from_albums, songs_from_artists)
    return songs.flatten
  end

  def custom(params)
    if params["includes"]
  byebug
      tables = get_table_names(params["includes"])
      return_hash = {}
      params["includes"].each_with_index{|item, index|
          return_hash[item] = tables[index].search(params["query_string"])
        }
      return return_hash
    else



    end

  end


  private

  def get_table_names(array)
    return array.collect{|item|
      ActiveSupport::Inflector.classify(item).constantize
    }
  end

end