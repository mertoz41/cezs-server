class PostSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :user_id, :genre_id, :instrument_id, :song_id, :artist_id, :clip

  def clip
    url_for(object.clip)
  end
end
