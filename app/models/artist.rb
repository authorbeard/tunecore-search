class Artist < ApplicationRecord
  has_many :albums
  has_many :songs, through: :albums

  def self.find_by(query_string)
    
  end
end
