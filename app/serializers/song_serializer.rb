class SongSerializer < ActiveModel::Serializer
  attributes :id, :name, :artist_id
end
