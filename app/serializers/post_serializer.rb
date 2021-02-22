class PostSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :genre_id, :instrument_id, :song_id, :integer, :artist_id, :integer
end
