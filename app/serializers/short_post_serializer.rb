class ShortPostSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :user_id, :thumbnail, :created_at, :instruments, :genre, :view_count
  attribute :song_name, if: -> {object.song.present?}
  attribute :artist_name, if: -> {object.artist.present?}

  def thumbnail
    url_for(object.thumbnail)
  end
  def instruments
    object.instruments.map do |instrument|
      instrument.name
    end
  end
  def genre
    return object.genre.name
  end
  def artist_name
    return object.artist.name
  end 

  def song_name
    return object.song.name
  end 

  def view_count
    object.postviews.size
  end
end
