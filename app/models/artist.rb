class Artist < ApplicationRecord
    has_many :songs, dependent: :destroy
    has_many :posts, dependent: :destroy
    has_many :postviews, through: :posts
    

    has_many :artistfollows, dependent: :destroy
    has_many :followingusers, through: :artistfollows

    has_many :userartists, dependent: :destroy
    has_many :favoriteusers, through: :userartists

    def user_follows(user_id)
        return  self.followingusers.find_by(id: user_id) ? true : false
    end

    def user_favorites(user_id)

        return self.favoriteusers.find_by(id: user_id)  ? true : false
    end

end
