class Artist < ApplicationRecord
  has_many :albums
  has_many :songs, through: :albums

  def self.search(query)
  byebug
    q=query.split(",").map{|string|

  byebug
      string = "%#{string.strip}%"
    }

    combined_results = q.map{|q_string|
      group(:name).where("name LIKE ?", q).to_a
    }

    return combined_results

  end
end
