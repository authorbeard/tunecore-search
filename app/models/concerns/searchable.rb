module Searchable

  def search(query)
 
    q=query.split(",").map{|string|
      string = "%#{string.strip}%"
    }

    combined_results = q.map{|q_string|
      where("name LIKE ?", q_string).to_a
    }
    return combined_results.flatten

  end

end