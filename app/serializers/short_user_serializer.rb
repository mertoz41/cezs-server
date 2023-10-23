class ShortUserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :username, :location, :instruments, :genres, :name, :posts
  attribute :avatar, if: -> {object.avatar.present?}
  # has_many :posts, serializer: ShortPostSerializer

  def posts
    filtered_posts = object.posts.select {|post| post.reports.size < 1}
    filtered_posts.map do |post| ShortPostSerializer.new(post)
    end
  end
  def instruments
    object.instruments.map do |inst|
      {id: inst.id, name: inst.name}
    end
  end
  def genres
    object.genres.map do |genr|
      {id: genr.id, name: genr.name}
    end
  end
  def avatar
    return "#{ENV['CLOUDFRONT_API']}#{object.avatar.key}"
  end

end
