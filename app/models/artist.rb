class Artist < ApplicationRecord
  has_many :albums
  has_many :songs, through: :albums

  extend Searchable

  # scope :song_ids, lambda {|query| search(query).map{|a| a.songs.pluck(:id)}.flatten }


end
