class SearchController < ApplicationController
    def exploredata
        genres = Genre.all
        instruments = Instrument.all
        artist_views = Artist.left_joins(:postviews).group(:id).order('COUNT(postviews.id) DESC').first(5).map { |artis| {id: artis.id, name: artis.name, spotify_id: artis.spotify_id, view_count: artis.postviews.size}}
        song_views = Song.left_joins(:postviews).group(:id).order('COUNT(postviews.id) DESC').first(5).map { |song| {id: song.id, name: song.name, artist_name: song.artist.name, spotify_id: song.spotify_id, view_count: song.postviews.size}}
        album_views = Album.left_joins(:postviews).group(:id).order('COUNT(postviews.id) DESC').first(5).map { |album| {id: album.id, name: album.name, artist_name: album.artist.name, spotify_id: album.spotify_id, view_count: album.postviews.size, artistSpotifyId: album.artist.spotify_id}}

        artist_posts = Artist.left_joins(:posts).group(:id).order('COUNT(posts.id) DESC').first(5).map { |artis| {id: artis.id, name: artis.name, spotify_id: artis.spotify_id, post_count: artis.posts.size}}
        song_posts = Song.left_joins(:posts).group(:id).order('COUNT(posts.id) DESC').first(5).map { |song| {id: song.id, name: song.name, artist_name: song.artist.name, spotify_id: song.spotify_id, post_count: song.posts.size}}
        album_posts = Album.left_joins(:posts).group(:id).order('COUNT(posts.id) DESC').first(5).map { |album| {id: album.id, name: album.name, artist_name: album.artist.name, spotify_id: album.spotify_id, post_count: album.posts.size, artistSpotifyId: album.artist.spotify_id}}
        # artist need to have id, name, spotify_id
        # song needs to have id, name, artist_name, spotify_id
        # album needs to have id, name, artist_name, spotify_id

        render json: {
            genres: genres, 
            instruments: instruments, 
            artist_views: artist_views, 
            song_views: song_views, 
            album_views: album_views,
            artist_posts: artist_posts,
            song_posts: song_posts,
            album_posts: album_posts
        }
        # artists with most posts
        # songs with most posts
        # albums with most posts 
    end
    def filters
        @genres = Genre.all
        @instruments = Instrument.all
        render json: {
            genres: ActiveModel::Serializer::CollectionSerializer.new(@genres, each_serializer: GenreSerializer),
            instruments: ActiveModel::Serializer::CollectionSerializer.new(@instruments, each_serializer: InstrumentSerializer)
        }
    end
end
