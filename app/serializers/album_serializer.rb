class AlbumSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_one :artist, only: [:name, :id]
  has_many :songs, only: [:name, :id]
end
