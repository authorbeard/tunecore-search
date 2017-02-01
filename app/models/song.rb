class Song < ApplicationRecord
  belongs_to :album, optional: true
  has_one :artist, through: :album

  after_update :set_artist, if: :has_album?

  def has_album?
    !!self.album
  end

  def set_artist
    self.artist = self.album.artist
  end
end
