class RequestSerializer < ActiveModel::Serializer
  attributes :id, :fulfilled, :user_id, :artist_id, :song_id
end
