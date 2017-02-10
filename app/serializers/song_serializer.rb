class SongSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_one :album, only: [:name, :id, :artist]

end
