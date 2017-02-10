class SearchService


  def initialize
  end

  def default(params)
    query = params["query_string"]
    songs_from_artists = Artist.song_ids(query)
    songs_from_albums = Album.song_ids(query)

    songs=Song.search(query) << Song.find([songs_from_albums, songs_from_artists].flatten)
    return songs.flatten
  end

  def custom(params)
    if params["includes"]
      tables = get_table_names(params["includes"])
      results =[]
      tables.each{|t|
        if t == Song 
          results << Song.search(params["query_string"])
        else
          ids = t.song_ids(params["query_string"])
          results << Song.find(ids)
        end
      }
      return results.flatten
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