class Artist < ApplicationRecord
  has_many :albums
  has_many :songs, through: :albums

  def self.search(query)
    q=query.split(",").map{|string|
      string = "%#{string}%"
    }
    return group(:name).where("name LIKE ?", q).to_a

  end
end
