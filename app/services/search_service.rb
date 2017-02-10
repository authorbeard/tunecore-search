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
byebug  
      base = get_table_names([params["narrow_by"]]).first
      target = base.search(params['narrow_query']).pop
      album_matches = target.albums.song_ids(params['query_string'])
      results = target.songs.search(params["query_string"])
      results << Song.find(album_matches)
      return results.flatten
  byebug

    end

  end


  private

  def get_table_names(array)
    return array.collect{|item|
      ActiveSupport::Inflector.classify(item).constantize
    }
  end

end