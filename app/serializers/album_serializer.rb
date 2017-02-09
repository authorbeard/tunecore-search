class AlbumSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_one :artist
  has_many :songs
end
