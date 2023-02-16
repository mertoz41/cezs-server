class SearchController < ApplicationController
    def exploredata
        genres = Genre.all
        instruments = Instrument.all
        artist_views = Artist.left_joins(:postviews).group(:id).order('COUNT(postviews.id) DESC').first(5).map { |artis| {id: artis.id, name: artis.name, spotify_id: artis.spotify_id, view_count: artis.postviews.size}}
        song_views = Song.left_joins(:postviews).group(:id).order('COUNT(postviews.id) DESC').first(5).map { |song| {id: song.id, name: song.name, artist_name: song.artist.name, spotify_id: song.spotify_id, view_count: song.postviews.size, artistSpotifyId: song.artist.spotify_id}}

        artist_posts = Artist.left_joins(:posts).group(:id).order('COUNT(posts.id) DESC').first(5).map { |artis| {id: artis.id, name: artis.name, spotify_id: artis.spotify_id, post_count: artis.posts.size}}
        song_posts = Song.left_joins(:posts).group(:id).order('COUNT(posts.id) DESC').first(5).map { |song| {id: song.id, name: song.name, artist_name: song.artist.name, spotify_id: song.spotify_id, post_count: song.posts.size, artistSpotifyId: song.artist.spotify_id}}
        # artist need to have id, name, spotify_id
        # song needs to have id, name, artist_name, spotify_id
        # album needs to have id, name, artist_name, spotify_id

        render json: {
            genres: genres, 
            instruments: instruments, 
            artist_views: artist_views, 
            song_views: song_views, 
            artist_posts: artist_posts,
            song_posts: song_posts,
        }
        # artists with most posts
        # songs with most posts
        # albums with most posts 
    end
    def get_instruments_genres
        @genres = Genre.all
        @instruments = Instrument.all
        render json:{
            instruments: ActiveModel::Serializer::CollectionSerializer.new(@instruments, each_serializer: InstrumentSerializer), 
            genres: ActiveModel::Serializer::CollectionSerializer.new(@genres, each_serializer: GenreSerializer)
        }
        
    end
end
