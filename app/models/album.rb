class Album < ApplicationRecord
  belongs_to :artist, optional: true
  has_many :songs

  extend Searchable

  scope :song_ids, lambda {|query| search(query).map{|a| a.songs.pluck(:id)}.flatten }
  
end
