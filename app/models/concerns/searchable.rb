module Searchable

  def search(query)
    q_array=query.split(",").map{|string|
      string = "%#{string.strip}%"
    }

    combined_results = q_array.map{|q_string|
      where("name LIKE ?", q_string).to_a
    }
    return combined_results.flatten
  end

  def narrow_search(query)

  end

end