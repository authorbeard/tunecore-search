class Song < ApplicationRecord
  belongs_to :album, optional: true
  delegate :artist, :to => :album
end
