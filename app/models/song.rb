class Song < ApplicationRecord
  belongs_to :album, optional: true
  has_one :artist, through: :album

  extend Searchable

end
