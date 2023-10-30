class Band < ApplicationRecord
    has_one_attached :picture
    has_many :bandmembers, dependent: :destroy
    has_many :members, through: :bandmembers

    has_one :notification, dependent: :destroy
    has_one :bandlocation, dependent: :destroy
    has_one :location, through: :bandlocation
    has_many :reports, dependent: :destroy

    has_many :posts, dependent: :destroy
    has_many :songs, through: :posts

    has_many :bandfollows, dependent: :destroy
    has_many :followers, through: :bandfollows

    has_many :events, dependent: :destroy

    has_many :bandgenres, dependent: :destroy
    has_many :genres, through: :bandgenres

    def complete_band_setup(picture, members, genres, location_id, creator_id)
        self.picture.attach(picture)
        members = JSON.parse members
        members.each do |id|
            Bandmember.create(user_id: id, band_id: self.id)
        end
        genres = JSON.parse genres
        genres.each do |genre|
            found_genre = Genre.find_or_create_by(name: genre)
            Bandgenre.create(band_id: self.id, genre_id: found_genre.id)
        end
        filtered_members = members.select {|id| id != creator_id}
        filtered_members.each do |id|
            CreateNotificationJob.perform_later({band_id: self.id, action_user_id: creator_id, user_id: id})
        end

        location = Location.find(location_id)
        Bandlocation.create(band_id: self.id, location_id: location.id)
    end

    def update_band(params)
        if params[:name]
            self.update_column 'name', params[:name]
        end
        if params[:bio]
            self.update_column 'bio', params[:bio]
        end
        if params[:picture]
            self.picture.purge
            self.picture.attach(params[:picture])
        end
        if params[:locationLatitude]
            location = Location.find_or_create_by(city: params[:city], latitude: params[:locationLatitude], longitude: params[:locationLongitude])
            band_location = Bandlocation.find_by(band_id: self.id, location_id: self.location.id)
            band_location.update(location_id: location.id)
        end
        if params[:genres]
            params[:genres].each do |genre|
                found_genre = Genre.find_or_create_by(name: genre)
                Bandgenre.create(genre_id: found_genre.id, band_id: self.id)
            end
        end
        if params[:members]
            params[:members].each do |member|
                Bandmember.create({user_id: member.to_i, band_id: self.id})
            end
        end
        if params[:removedMembers]
            params[:removedMembers].each do |member|
            instance = Bandmember.find_by(user_id: member.to_i, band_id: self.id)
            instance.destroy
            end
        end
        if params[:removedGenres]
            params[:removedGenres].each do |genre|
                instance = Bandgenre.find_by(genre_id: genre.to_i, band_id: self.id)
                instance.destroy
            end
        end
    end

end
