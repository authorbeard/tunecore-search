class Artist < ApplicationRecord
  has_many :albums
  has_many :songs, through: :albums

  def self.search(query)
    q=query.split(",").map{|string|
      string = "%#{string.strip}%"
    }

    combined_results = q.map{|q_string|
      group(:name).where("name LIKE ?", q_string).to_a
    }
    return combined_results.flatten

  end
end
