class SearchController < ApplicationController
    def exploredata

        genres = Genre.all
        instruments = Instrument.all

        post_instrument_filters = Instrument.where.associated(:posts).uniq
        account_instrument_filters = Instrument.where.associated(:users).uniq
        post_genre_filters = Genre.where.associated(:posts).uniq
        genres = Genre.where.associated(:users) + Genre.where.associated(:bands)
        account_genre_filters = genres.uniq
        last_posts = Post.all
        last_bands = Band.all
        last_users = User.all 
        # need
        #  post numbers, band numbers, user numbers, song numbers, artist numbers
        # post filters
        # band filters
        # user filters
        # song filters
        # 
        # byebug
        # genres = Genre.all
        # instruments = Instrument.all
        artist_views = Artist.left_joins(:postviews).group(:id).order('COUNT(postviews.id) DESC').first(5).map { |artis| {id: artis.id, name: artis.name, view_count: artis.postviews.size}}
        song_views = Song.left_joins(:postviews).group(:id).order('COUNT(postviews.id) DESC').first(5).map { |song| {id: song.id, name: song.name, artist_name: song.artist.name, view_count: song.postviews.size}}

        artist_posts = Artist.left_joins(:posts).group(:id).order('COUNT(posts.id) DESC').first(5).map { |artis| {id: artis.id, name: artis.name, post_count: artis.posts.size}}
        song_posts = Song.left_joins(:posts).group(:id).order('COUNT(posts.id) DESC').first(5).map { |song| {id: song.id, name: song.name, artist_name: song.artist.name, post_count: song.posts.size}}


        render json: {
            genres: genres,
            instruments: instruments,
            last_posts:  ActiveModel::Serializer::CollectionSerializer.new(last_posts.sort_by(&:created_at).reverse, serializer: ShortPostSerializer),
            last_bands:  ActiveModel::Serializer::CollectionSerializer.new(last_bands.sort_by(&:created_at).reverse, serializer: ShortBandSerializer),
            last_users:  ActiveModel::Serializer::CollectionSerializer.new(last_users.sort_by(&:created_at).reverse, serializer: ShortUserSerializer),
            post_count: Post.all.size,
            user_count: User.all.size,
            band_count: Band.all.size,
            song_count: Song.all.size,
            artist_count: Artist.all.size,
            post_instrument_filters: post_instrument_filters,
            account_instrument_filters: account_instrument_filters,
            post_genre_filters: post_genre_filters,
            account_genre_filters: account_genre_filters,



            artist_views: artist_views, 
            song_views: song_views, 
            artist_posts: artist_posts,
            song_posts: song_posts,
        }
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
