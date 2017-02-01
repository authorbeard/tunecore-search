class Song < ApplicationRecord
  belongs_to :album, optional: true
  has_one :artist, through: :album

  # after_save :set_artist, if: :has_album?

#   def has_album?
#     !!album_id
#   end

#   def set_artist
# # byebug
#     self.artist = self.album.artist
#   end
end
