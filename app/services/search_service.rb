class SearchService


  def initialize
  end

  def default(params)
    query = params["query_string"]
    songs_from_artists = Artist.matching_song_ids(query)
    songs_from_albums = Album.matching_song_ids(query)

    songs=Song.search(query) << Song.find([songs_from_albums, songs_from_artists].flatten)
    return songs.flatten
  end

  def custom(params)
    if params["includes"]
      tables = params["includes"].collect{|i| get_table_name(i)}
      results =[]
      tables.each{|t|
        if t == Song 
          results << Song.search(params["query_string"])
        else
          ids = t.matching_song_ids(params["query_string"])
          results << Song.find(ids)
        end
      }
      return results.flatten
    else
  # byebug
      narrow_class = get_table_name(params["narrow_by"])
      narrow_record = narrow_class.search(params['narrow_query']).pop
      song_ids=narrow_record.songs.pluck(:id)
      return Song.find(song_ids).select{|song|
        song.name.downcase.include?(params["query_string"])
      }
    end

  end


  private

  def get_table_name(string)
    return ActiveSupport::Inflector.classify(string).constantize
  end


end