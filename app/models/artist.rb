class Artist < ApplicationRecord
  has_many :albums
  has_many :songs, through: :albums

  def self.search
    # return true
  end
end
